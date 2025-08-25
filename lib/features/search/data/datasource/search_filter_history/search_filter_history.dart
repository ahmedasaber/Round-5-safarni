import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class SearchFilterHistoryDataSource {
  final Box<String> box;

  SearchFilterHistoryDataSource({required this.box});

  /// Save search query
  Future<void> saveSearch(String query) async {
    if (query.trim().isEmpty) return;

    // Prevent duplicates
    if (!box.values.contains(query)) {
      await box.add(query);
    }
  }

  /// Get all search history
  Future<List<String>> getHistory() async {
    return box.values.toList();
  }

  /// Delete a single item
  Future<void> deleteItem(String query) async {
    final key = box.keys.firstWhere(
          (k) => box.get(k) == query,
      orElse: () => null,
    );
    if (key != null) {
      await box.delete(key);
    }
  }

  /// Clear all history
  Future<void> clearHistory() async {
    await box.clear();
  }

  /// Listen for changes
  ValueListenable<Box<String>> listenable() {
    return box.listenable();
  }
}
