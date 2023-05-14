import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ninja/bloc/profile/profile_bloc.dart';
import 'package:food_ninja/models/food.dart';
import 'package:food_ninja/models/restaurant.dart';
import 'package:food_ninja/models/user.dart';
import 'package:food_ninja/ui/widgets/items/food_item.dart';
import 'package:food_ninja/ui/widgets/items/restaurant_item.dart';
import 'package:food_ninja/utils/app_colors.dart';
import 'package:food_ninja/utils/app_styles.dart';
import 'package:food_ninja/utils/custom_text_style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User _user = User.fromHive();
  final List<Food> _favoriteFoods = [];
  final List<Restaurant> _favoriteRestaurants = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(
      LoadFavoriteFoods(),
    );

    BlocProvider.of<ProfileBloc>(context).add(
      LoadFavoriteRestaurants(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/home');
        return true;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              flexibleSpace: Stack(
                children: [
                  FlexibleSpaceBar(
                    background: _user.image != null
                        ? Image.network(
                            _user.image!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/png/no-image.png",
                            fit: BoxFit.cover,
                          ),
                  ),
                  //Border radius
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.cardColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  0,
                  20,
                  40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: AppStyles.largeBorderRadius,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.secondaryColor.withOpacity(0.1),
                                AppColors.secondaryDarkColor.withOpacity(0.1),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Text(
                            'Member Gold',
                            style: CustomTextStyle.size14Weight400Text(
                              AppColors.starColor,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: AppStyles.largeBorderRadius,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.secondaryColor.withOpacity(0.1),
                                AppColors.secondaryDarkColor.withOpacity(0.1),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/settings',
                              );
                            },
                            icon: const Icon(
                              Icons.settings,
                              color: AppColors.starColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _user.fullName,
                      style: CustomTextStyle.size27Weight600Text(),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _user.email,
                      style: CustomTextStyle.size14Weight400Text(
                        AppColors.grayColor.withOpacity(0.3),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Favorite Foods',
                      style: CustomTextStyle.size18Weight600Text(),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        if (state is FavoriteFoodsLoading) {
                          return const FoodItemShimmer();
                        } else if (state is FavoriteFoodsLoaded) {
                          _favoriteFoods.clear();
                          _favoriteFoods.addAll(state.favoriteFoods);

                          if (_favoriteFoods.isEmpty) {
                            return Center(
                              child: Text(
                                'No favorite foods',
                                style: CustomTextStyle.size16Weight400Text(
                                  AppColors.grayColor.withOpacity(0.3),
                                ),
                              ),
                            );
                          }
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _favoriteFoods.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  FoodItem(food: _favoriteFoods[index]),
                                  const SizedBox(height: 20),
                                ],
                              );
                            },
                          );
                        } else {
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _favoriteFoods.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  FoodItem(food: _favoriteFoods[index]),
                                  const SizedBox(height: 20),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Favorite Restaurants',
                      style: CustomTextStyle.size18Weight600Text(),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        if (state is FavoriteRestaurantsLoading) {
                          return const FoodItemShimmer();
                        } else if (state is FavoriteRestaurantsLoaded) {
                          _favoriteRestaurants.clear();
                          _favoriteRestaurants
                              .addAll(state.favoriteRestaurants);

                          if (_favoriteRestaurants.isEmpty) {
                            return Center(
                              child: Text(
                                'No favorite restaurants',
                                style: CustomTextStyle.size16Weight400Text(
                                  AppColors.grayColor.withOpacity(0.3),
                                ),
                              ),
                            );
                          }

                          return SizedBox(
                            height: 200,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              children: _favoriteRestaurants.map((restaurant) {
                                return Container(
                                  width: 150,
                                  margin: const EdgeInsets.only(right: 20),
                                  child: RestaurantItem(
                                    restaurant: restaurant,
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        }
                        return SizedBox(
                          height: 200,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            children: _favoriteRestaurants.map((restaurant) {
                              return RestaurantItem(
                                restaurant: restaurant,
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
