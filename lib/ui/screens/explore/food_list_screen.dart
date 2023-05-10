import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ninja/bloc/food/food_bloc.dart';
import 'package:food_ninja/models/food.dart';
import 'package:food_ninja/ui/widgets/food_item.dart';
import 'package:food_ninja/ui/widgets/search_filter_widget.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({super.key});

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Food> _foods = [];
  final int _foodLimit = 10;

  @override
  void initState() {
    BlocProvider.of<FoodBloc>(context).add(
      LoadFoods(
        limit: _foodLimit,
        lastDocument: null,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: SearchFilterWidget(searchController: _searchController),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          left: 25,
          right: 25,
          bottom: 50,
          // top: 25,
        ),
        child: BlocBuilder<FoodBloc, FoodState>(
          builder: (context, state) {
            if (state is FoodLoading) {
              return const FoodItemShimmer();
            } else if (state is FoodLoaded) {
              _foods.clear();
              _foods.addAll(state.foods);
              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _foods.length > 5 ? 5 : _foods.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: FoodItem(food: _foods[index]),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('Failed to fetch foods'),
              );
            }
          },
        ),
      ),
    );
  }
}
