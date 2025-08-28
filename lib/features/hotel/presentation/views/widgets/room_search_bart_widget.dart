import 'dart:async';

import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';

class LocalRoomSearchWidget extends StatefulWidget {
  final Function(String) onSearchChanged;
  final Function() onClearSearch;
  final int? hotelId;

  const LocalRoomSearchWidget({
    super.key,
    required this.onSearchChanged,
    required this.onClearSearch,
    this.hotelId,
  });

  @override
  State<LocalRoomSearchWidget> createState() => _LocalRoomSearchWidgetState();
}

class _LocalRoomSearchWidgetState extends State<LocalRoomSearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      widget.onSearchChanged(query);
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _debounceTimer?.cancel();
    widget.onClearSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          hintText: widget.hotelId != null
              ? 'Search rooms in this hotel...'
              : 'Search available rooms...',
          hintStyle: TextStyles.font15LightGrayNormal,
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 30),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey[400]),
                  onPressed: _clearSearch,
                )
              : null,
        ),
      ),
    );
  }
}
