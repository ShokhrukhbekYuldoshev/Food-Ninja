import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ninja/bloc/restaurant/restaurant_bloc.dart';
import 'package:food_ninja/models/restaurant.dart';
import 'package:food_ninja/ui/widgets/filter_dialog.dart';
import 'package:food_ninja/ui/widgets/items/restaurant_item.dart';
import 'package:food_ninja/ui/widgets/search_filter_widget.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  List<Restaurant> _restaurants = [];
  List<Restaurant> _filteredRestaurants = [];

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
    return GestureDetector(
      onTap: () {
        // close keyboard
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Restaurants'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(75),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                25,
                0,
                25,
                25,
              ),
              child: SearchFilterWidget(
                searchController: _searchController,
                onChanged: (value) {
                  _filteredRestaurants = _restaurants
                      .where((restaurant) => restaurant.name
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                  BlocProvider.of<RestaurantBloc>(context).add(
                    SearchRestaurants(),
                  );
                },
                onTap: () {
                  // open filter dialog
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const FilterDialog();
                    },
                  );
                },
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(
              left: 25,
              right: 25,
              bottom: 50,
              // top: 25,
            ),
            child: BlocBuilder<RestaurantBloc, RestaurantState>(
              builder: (context, state) {
                if (state is RestaurantsLoadingError) {
                  return const Center(
                    child: Text('Error loading restaurants'),
                  );
                }
                if (state is RestaurantsLoading) {
                  return GridView.builder(
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
                  );
                } else if (state is RestaurantsLoaded) {
                  _restaurants = state.restaurants;
                  _filteredRestaurants = state.restaurants;
                  return GridView.builder(
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
                } else if (state is SearchUpdated) {
                  return GridView.builder(
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
                }
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
          ),
        ),
      ),
    );
  }
}
