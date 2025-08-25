import 'dart:async';

import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';

class LocalRoomSearchWidget extends StatefulWidget {
  final Function(String) onSearchChanged; // Callback للبحث
  final Function() onClearSearch; // Callback لمسح البحث
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
    // Cancel previous timer
    _debounceTimer?.cancel();

    // Start new timer - بانتظار المستخدم ينتهي من الكتابة
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      // استدعاء الـ callback مع النص
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