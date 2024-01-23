import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ninja/src/bloc/restaurant/restaurant_bloc.dart';
import 'package:food_ninja/src/data/models/restaurant.dart';
import 'package:food_ninja/src/presentation/widgets/buttons/back_button.dart';
import 'package:food_ninja/src/presentation/widgets/items/restaurant_item.dart';
import 'package:food_ninja/src/presentation/widgets/search_field.dart';
import 'package:food_ninja/src/presentation/utils/app_colors.dart';
import 'package:food_ninja/src/presentation/utils/app_styles.dart';
import 'package:food_ninja/src/presentation/utils/custom_text_style.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  List<Restaurant> _restaurants = [];
  List<Restaurant> _filteredRestaurants = [];
  bool _isLoading = false;

  final TextEditingController _searchController = TextEditingController();

  final int _restaurantLimit = 10;

  @override
  void initState() {
    BlocProvider.of<RestaurantBloc>(context).add(
      LoadRestaurants(
        limit: _restaurantLimit,
        lastDocument: null,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RestaurantBloc, RestaurantState>(
      listener: (context, state) {
        if (state is RestaurantsLoading) {
          _isLoading = true;
        } else if (state is RestaurantsLoadingError) {
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.errorColor,
            ),
          );
        } else if (state is RestaurantsLoaded) {
          _isLoading = false;
          _restaurants = state.restaurants;
          _filteredRestaurants = state.restaurants;
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  "assets/svg/pattern-small.svg",
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomBackButton(),
                            const SizedBox(height: 20),
                            Text(
                              "Restaurants",
                              style: CustomTextStyle.size25Weight600Text(),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: AppStyles.defaultTextFieldHeight,
                              child: Row(
                                children: [
                                  SearchField(
                                    searchController: _searchController,
                                    onChanged: (value) {
                                      _filteredRestaurants = _restaurants
                                          .where((restaurant) => restaurant.name
                                              .toLowerCase()
                                              .contains(value.toLowerCase()))
                                          .toList();
                                      BlocProvider.of<RestaurantBloc>(context)
                                          .add(
                                        SearchRestaurants(),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                        BlocBuilder<RestaurantBloc, RestaurantState>(
                          builder: (context, state) {
                            return _isLoading
                                ? GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20,
                                    ),
                                    itemCount: _restaurantLimit,
                                    itemBuilder: (context, index) {
                                      return const RestaurantItemShimmer();
                                    },
                                  )
                                : GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20,
                                    ),
                                    itemCount: _filteredRestaurants.length,
                                    itemBuilder: (context, index) {
                                      return RestaurantItem(
                                        restaurant: _filteredRestaurants[index],
                                      );
                                    },
                                  );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
