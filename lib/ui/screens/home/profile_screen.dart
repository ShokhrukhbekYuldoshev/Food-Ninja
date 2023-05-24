import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ninja/bloc/profile/profile_bloc.dart';
import 'package:food_ninja/bloc/theme/theme_bloc.dart';
import 'package:food_ninja/models/user.dart';
import 'package:food_ninja/ui/widgets/image_placeholder.dart';
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

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(
      FetchFavorites(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
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
                                errorBuilder: (context, error, stackTrace) =>
                                    ImagePlaceholder(
                                  iconData: Icons.person,
                                  iconSize: 100,
                                ),
                              )
                            : ImagePlaceholder(
                                iconData: Icons.person,
                                iconSize: 100,
                              ),
                      ),
                      //Border radius
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors().backgroundColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                            border: Border.all(width: 0),
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
                                    AppColors.secondaryDarkColor
                                        .withOpacity(0.1),
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
                                    AppColors.secondaryDarkColor
                                        .withOpacity(0.1),
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
                            AppColors().secondaryTextColor,
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
                            if (state is FetchingFavorites) {
                              return const FoodItemShimmer();
                            } else if (state is FavoritesFetched) {
                              if (state.favoriteFoods.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No favorite foods',
                                    style: CustomTextStyle.size16Weight400Text(
                                      AppColors().secondaryTextColor,
                                    ),
                                  ),
                                );
                              }
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.favoriteFoods.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      FoodItem(
                                          food: state.favoriteFoods[index]),
                                      const SizedBox(height: 20),
                                    ],
                                  );
                                },
                              );
                            }
                            return const SizedBox();
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
                            if (state is FetchingFavorites) {
                              return const SizedBox(
                                width: 150,
                                height: 200,
                                child: RestaurantItemShimmer(),
                              );
                            } else if (state is FavoritesFetched) {
                              if (state.favoriteRestaurants.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No favorite restaurants',
                                    style: CustomTextStyle.size16Weight400Text(
                                      AppColors().secondaryTextColor,
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
                                  children: state.favoriteRestaurants
                                      .map((restaurant) {
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
                            return const SizedBox();
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
      },
    );
  }
}
