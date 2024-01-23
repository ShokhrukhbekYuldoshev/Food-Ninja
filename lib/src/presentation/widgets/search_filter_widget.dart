import 'package:flutter/material.dart';
import 'package:food_ninja/src/presentation/widgets/filter_widget.dart';
import 'package:food_ninja/src/presentation/widgets/search_field.dart';

class SearchFilterWidget extends StatelessWidget {
  const SearchFilterWidget({
    super.key,
    required this.searchController,
    required this.onChanged,
    required this.onTap,
  });

  final TextEditingController searchController;
  final Function(String)? onChanged;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          SearchField(
            searchController: searchController,
            onChanged: onChanged,
          ),
          const SizedBox(width: 10),
          FilterWidget(
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
