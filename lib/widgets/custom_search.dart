import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  final TextEditingController searchController;
  final void Function()? onMicTap;

  const CustomSearch({
    super.key,
    required this.searchController,
    this.onMicTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Rounded corners
        border: Border.all(color: Colors.grey.shade400, width: 1), // Border
        color: Colors.white,
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search Medicine Name",
          contentPadding:
              const EdgeInsets.symmetric(vertical: 11, horizontal: 12),
          border: InputBorder.none, // Removes default underline
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: IconButton(
            icon: const Icon(Icons.mic, color: Colors.black),
            onPressed: onMicTap,
          ),
        ),
      ),
    );
  }
}
