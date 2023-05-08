import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ninja/secrets.dart';
import 'package:food_ninja/services/firestore_db.dart';
import 'package:food_ninja/ui/widgets/buttons/back_button.dart';
import 'package:food_ninja/ui/widgets/buttons/default_button.dart';
import 'package:food_ninja/ui/widgets/buttons/primary_button.dart';
import 'package:food_ninja/models/user.dart';
import 'package:food_ninja/ui/widgets/loading_indicator.dart';
import 'package:food_ninja/utils/app_colors.dart';
import 'package:food_ninja/utils/app_styles.dart';
import 'package:food_ninja/utils/custom_text_style.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:food_ninja/services/geoservices.dart';

class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({super.key});

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  String locationText = "Your Location";
  var box = Hive.box('myBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              "assets/svg/pattern-small.svg",
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: PrimaryButton(
                text: "Next",
                onTap: () async {
                  if (box.get('location') == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Please set your location"),
                        backgroundColor: AppColors.errorColor,
                      ),
                    );
                    return;
                  }

                  box.put('isRegistered', true);

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const LoadingIndicator(),
                  );

                  FirestoreDatabase db = FirestoreDatabase();
                  await db.addDocument(
                    'users',
                    User.fromHive().toMap(),
                  );
                  if (mounted) {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/register/success');
                  }
                },
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top + 40,
                  ),
                  const CustomBackButton(),
                  const SizedBox(height: 20),
                  Text(
                    "Set Your Location",
                    style: CustomTextStyle.size25Weight700Text(),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "This data will be displayed in your account \nprofile for security",
                    style: CustomTextStyle.size12Weight400Text(),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.fromLTRB(
                      10,
                      20,
                      10,
                      10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cardColor,
                      boxShadow: [AppStyles.defaultBoxShadow],
                      borderRadius: AppStyles.largeBorderRadius,
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/map-pin.svg",
                              width: 33,
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                locationText,
                                style: CustomTextStyle.size16Weight400Text(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 27),
                        SizedBox(
                          width: double.infinity,
                          child: DefaultButton(
                            text: "Set Location",
                            onTap: () async {
                              LatLng latLng = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MapScreen(),
                                ),
                              );

                              String placeName = await getAddressFromPosition(
                                latLng.latitude,
                                latLng.longitude,
                              );

                              setState(() {
                                locationText = placeName;
                              });

                              // save data to hive

                              box.put('location', placeName);
                            },
                            backgroundColor: AppColors.grayLightColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static Position? _currentPosition;

  @override
  void initState() {
    super.initState();

    getCurrentLocation().then((value) {
      setState(() {
        _currentPosition = value;
      });
    });
  }

  LatLng selectedLocation = LatLng(
    _currentPosition?.latitude ?? 37.7749,
    _currentPosition?.longitude ?? -122.4194,
  );

  void _selectLocation(LatLng position) {
    setState(() {
      selectedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCurrentLocation(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildMap();
        } else {
          return const LoadingIndicator();
        }
      },
    );
  }

  Widget _buildMap() {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          zoom: 18.0,
          maxZoom: 18.0,
          center: selectedLocation,
          onTap: (tapPosition, latLng) => _selectLocation(latLng),
          maxBounds: LatLngBounds(
            LatLng(-90, -180.0),
            LatLng(90.0, 180.0),
          ),
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/mapbox/streets-v12/tiles/{z}/{x}/{y}?access_token=$MAPBOX_ACCESS_TOKEN",
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 216,
                height: 216,
                point: selectedLocation,
                builder: (ctx) => SvgPicture.asset(
                  "assets/svg/map-pin-radar.svg",
                  width: 30,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryDarkColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.pop(context, selectedLocation);
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
