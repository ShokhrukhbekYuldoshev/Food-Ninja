import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ninja/bloc/restaurant/restaurant_bloc.dart';
import 'package:food_ninja/models/restaurant.dart';
import 'package:food_ninja/ui/widgets/restaurant_item.dart';
import 'package:food_ninja/ui/widgets/search_filter_widget.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Restaurant> _restaurants = [];
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
    return Scaffold(
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
            child: SearchFilterWidget(searchController: _searchController),
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
              if (state is RestaurantLoading) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
              } else if (state is RestaurantLoaded) {
                _restaurants.clear();
                _restaurants.addAll(state.restaurants);
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: _restaurants.length,
                  itemBuilder: (context, index) {
                    return RestaurantItem(
                      restaurant: _restaurants[index],
                    );
                  },
                );
              }
              return const Center(
                child: Text('Failed to fetch restaurants'),
              );
            },
          ),
        ),
      ),
    );
  }
}
