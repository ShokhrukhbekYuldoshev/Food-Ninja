import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ninja/src/bloc/testimonial/testimonial_bloc.dart';
import 'package:food_ninja/src/data/models/order.dart' as model;
import 'package:food_ninja/src/data/models/restaurant.dart';
import 'package:food_ninja/src/data/services/firestore_db.dart';
import 'package:food_ninja/src/presentation/widgets/buttons/primary_button.dart';
import 'package:food_ninja/src/presentation/widgets/buttons/secondary_button.dart';
import 'package:food_ninja/src/presentation/widgets/image_placeholder.dart';
import 'package:food_ninja/src/presentation/widgets/loading_indicator.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';
import 'package:food_ninja/src/presentation/utils/app_styles.dart';
import 'package:food_ninja/src/presentation/utils/custom_text_style.dart';

class ReviewScreen extends StatefulWidget {
  final model.Order order;
  const ReviewScreen({super.key, required this.order});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final FirestoreDatabase _db = FirestoreDatabase();
  final TextEditingController _reviewController = TextEditingController();
  bool isRestaurant = true;
  int cartIndex = -1;

  late Restaurant _restaurant;
  Future<void> _getRestaurant() async {
    var value = await _db.getDocumentFromReference(widget.order.restaurant);
    var map = value.data() as Map<String, dynamic>;
    _restaurant = Restaurant.fromMap(map);
  }

  @override
  void initState() {
    super.initState();

    _getRestaurant();
  }

  double _rating = 3;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getRestaurant(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildUI(context);
        } else {
          return const Scaffold(
            body: LoadingIndicator(),
          );
        }
      },
    );
  }

  BlocListener _buildUI(BuildContext context) {
    return BlocListener<TestimonialBloc, TestimonialState>(
      listener: (context, state) {
        if (state is TestimonialSuccess) {
          Navigator.pop(context);
          // change the cart index
          if (cartIndex < widget.order.cart.length - 1) {
            setState(() {
              cartIndex++;
            });
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
            );
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Review submitted successfully",
              ),
              backgroundColor: AppColors.primaryColor,
            ),
          );
        } else if (state is TestimonialFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Failed to submit review",
              ),
              backgroundColor: AppColors.primaryColor,
            ),
          );
        } else if (state is TestimonialLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const LoadingIndicator(),
          );
        }
      },
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
          child: IntrinsicHeight(
            child: Column(
              children: [
                Container(
                  height: AppStyles.defaultTextFieldHeight,
                  decoration: BoxDecoration(
                    boxShadow: [AppStyles.boxShadow7],
                  ),
                  child: TextField(
                    readOnly: true,
                    controller: _reviewController,
                    onTap: () {
                      // open a dialog
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Review",
                              style: CustomTextStyle.size18Weight600Text(),
                            ),
                            content: Container(
                              height: AppStyles.defaultTextFieldHeight,
                              decoration: BoxDecoration(
                                boxShadow: [AppStyles.boxShadow7],
                              ),
                              child: TextField(
                                controller: _reviewController,
                                decoration: InputDecoration(
                                  fillColor: AppColors().cardColor,
                                  filled: true,
                                  hintText: "Leave a feedback",
                                  hintStyle:
                                      CustomTextStyle.size14Weight400Text(
                                    AppColors().secondaryTextColor,
                                  ),
                                  enabledBorder:
                                      AppStyles().defaultEnabledBorder,
                                  focusedBorder:
                                      AppStyles.defaultFocusedBorder(),
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  _reviewController.clear();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancel",
                                  style: CustomTextStyle.size14Weight400Text(
                                    AppColors.errorColor,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Submit",
                                  style: CustomTextStyle.size14Weight400Text(
                                    AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    decoration: InputDecoration(
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          "assets/svg/edit.svg",
                        ),
                      ),
                      fillColor: AppColors().cardColor,
                      filled: true,
                      hintText: "Leave a feedback",
                      hintStyle: CustomTextStyle.size14Weight400Text(
                        AppColors().secondaryTextColor,
                      ),
                      enabledBorder: AppStyles().defaultEnabledBorder,
                      focusedBorder: AppStyles.defaultFocusedBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        text: "Submit",
                        onTap: () {
                          DocumentReference target = widget.order.restaurant;
                          if (!isRestaurant) {
                            target = FirebaseFirestore.instance.doc(
                                '/foods/${widget.order.cart[cartIndex].id}');
                          }
                          BlocProvider.of<TestimonialBloc>(context).add(
                            AddTestimonial(
                              rating: _rating,
                              review: _reviewController.text,
                              target: target,
                            ),
                          );

                          // clear the review controller
                          _reviewController.clear();
                          // change the rating to 3
                          _rating = 3;
                          // set isRestaurant to false
                          isRestaurant = false;
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    SecondaryButton(
                      text: "Skip",
                      onTap: () {
                        // clear the review controller
                        _reviewController.clear();
                        // change the rating to 3
                        _rating = 3;
                        // set isRestaurant to false
                        isRestaurant = false;
                        // change the cart index
                        if (cartIndex < widget.order.cart.length - 1) {
                          setState(() {
                            cartIndex++;
                          });
                        } else {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/home',
                            (route) => false,
                          );
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                ).createShader(bounds),
                blendMode: BlendMode.dstIn,
                child: SvgPicture.asset(
                  "assets/svg/pattern-big.svg",
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: (isRestaurant
                                      ? _restaurant.image
                                      : widget.order.cart[cartIndex].image) !=
                                  null
                              ? Image.network(
                                  isRestaurant
                                      ? _restaurant.image!
                                      : widget.order.cart[cartIndex].image!,
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200,
                                  errorBuilder: (context, error, stackTrace) =>
                                      ImagePlaceholder(
                                    iconData: isRestaurant
                                        ? Icons.restaurant
                                        : Icons.fastfood,
                                    height: 200,
                                    width: 200,
                                    iconSize: 80,
                                  ),
                                )
                              : ImagePlaceholder(
                                  iconData: isRestaurant
                                      ? Icons.restaurant
                                      : Icons.fastfood,
                                  height: 200,
                                  width: 200,
                                  iconSize: 80,
                                ),
                        ),
                        const SizedBox(height: 60),
                        Text(
                          "Thank you!\nEnjoy your meal",
                          textAlign: TextAlign.center,
                          style: CustomTextStyle.size25Weight600Text(),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Please leave a review below for",
                          textAlign: TextAlign.center,
                          style: CustomTextStyle.size14Weight400Text(
                            AppColors().secondaryTextColor,
                          ),
                        ),
                        Text(
                          isRestaurant
                              ? _restaurant.name
                              : widget.order.cart[cartIndex].name,
                          textAlign: TextAlign.center,
                          style: CustomTextStyle.size14Weight600Text(
                            AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 40),
                        RatingBar.builder(
                          initialRating: _rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 10.0),
                          itemBuilder: (context, index) {
                            return SvgPicture.asset(
                              "assets/svg/star-gold.svg",
                            );
                          },
                          onRatingUpdate: (rating) {
                            _rating = rating;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
