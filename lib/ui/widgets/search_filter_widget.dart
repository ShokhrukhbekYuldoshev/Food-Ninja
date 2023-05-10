import 'package:flutter/material.dart';
import 'package:food_ninja/ui/widgets/filter_widget.dart';
import 'package:food_ninja/ui/widgets/search_field.dart';

class SearchFilterWidget extends StatelessWidget {
  const SearchFilterWidget({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          SearchField(searchController: _searchController),
          const SizedBox(width: 10),
          const FilterWidget(),
        ],
      ),
    );
  }
}
