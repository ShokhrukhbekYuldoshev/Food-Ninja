import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ninja/src/secrets.dart';
import 'package:food_ninja/src/data/services/geoservices.dart';
import 'package:food_ninja/src/presentation/widgets/loading_indicator.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';

class SetLocationMapScreen extends StatefulWidget {
  const SetLocationMapScreen({super.key});

  @override
  State<SetLocationMapScreen> createState() => _SetLocationMapScreenState();
}

class _SetLocationMapScreenState extends State<SetLocationMapScreen> {
  static Position? _currentPosition;

  @override
  void initState() {
    super.initState();

    Geoservices().getCurrentLocation().then((value) {
      if (mounted) {
        setState(() {
          _currentPosition = value;
        });
      }
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
      future: Geoservices().getCurrentLocation(),
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
      appBar: AppBar(
        title: const Text("Select Location"),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialZoom: 18.0,
          maxZoom: 18.0,
          initialCenter: selectedLocation,
          onTap: (tapPosition, latLng) => _selectLocation(latLng),
          cameraConstraint: CameraConstraint.contain(
            bounds: LatLngBounds(
              const LatLng(-90, -180.0),
              const LatLng(90.0, 180.0),
            ),
          ),
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/mapbox/streets-v12/tiles/{z}/{x}/{y}?access_token=$mapboxAccessToken",
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 216,
                height: 216,
                point: selectedLocation,
                child: SvgPicture.asset(
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
        onPressed: () async {
          String placeName = await Geoservices().reverseGeocoding(
            selectedLocation.latitude,
            selectedLocation.longitude,
          );

          // save data to hive
          Hive.box('myBox').put('location', placeName);

          if (mounted) {
            Navigator.pop(context);
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
