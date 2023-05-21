import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ninja/bloc/food/food_bloc.dart';
import 'package:food_ninja/models/food.dart';
import 'package:food_ninja/ui/widgets/filter_dialog.dart';
import 'package:food_ninja/ui/widgets/items/food_item.dart';
import 'package:food_ninja/ui/widgets/search_filter_widget.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({super.key});

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  // load more foods when user scroll to the bottom
  final ScrollController _scrollController = ScrollController();
  DocumentSnapshot? _lastDocument;

  List<Food> _foods = [];
  List<Food> _filteredFoods = [];

  final TextEditingController _searchController = TextEditingController();
  final int _foodLimit = 10;

  @override
  void initState() {
    BlocProvider.of<FoodBloc>(context).add(
      LoadFoods(
        limit: _foodLimit,
        lastDocument: _lastDocument,
      ),
    );

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        BlocProvider.of<FoodBloc>(context).add(
          FetchMoreFoods(
            limit: _foodLimit,
            lastDocument: _lastDocument,
          ),
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FoodBloc, FoodState>(
      listener: (context, state) {
        if (state is FoodError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
        if (state is FoodMoreFetched) {
          _lastDocument = state.lastDocument;
          for (var food in state.foods) {
            if (!_foods.contains(food)) {
              _foods.add(food);
            }
          }
        }
      },
      child: GestureDetector(
        onTap: () {
          // close keyboard
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Foods'),
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
                    _filteredFoods = _foods
                        .where((food) => food.name
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                    BlocProvider.of<FoodBloc>(context).add(SearchFoods());
                  },
                  onTap: () {
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
          body: Container(
            margin: const EdgeInsets.only(
              left: 25,
              right: 25,
              // top: 25,
            ),
            child: BlocBuilder<FoodBloc, FoodState>(
              builder: (context, state) {
                if (state is FoodLoading) {
                  return const FoodItemShimmer();
                } else if (state is FoodLoaded) {
                  _lastDocument = state.lastDocument;
                  _foods = state.foods;
                  _filteredFoods = _foods;
                  return ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: _filteredFoods.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: FoodItem(food: _filteredFoods[index]),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: _filteredFoods.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: FoodItem(food: _filteredFoods[index]),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
