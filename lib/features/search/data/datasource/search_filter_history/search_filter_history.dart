import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

class SearchFilterHistoryDataSource {
  final Box<String> box;

  SearchFilterHistoryDataSource({required this.box});

  Future<void> saveSearch(String query) async {
    if (query.trim().isEmpty) return;
    if (!box.values.contains(query)) {
      await box.add(query);
    }
  }

  Future<List<String>> getHistory() async {
    return box.values.toList();
  }
  Future<void> deleteItem(String query) async {
    final key = box.keys.firstWhere(
          (k) => box.get(k) == query,
      orElse: () => null,
    );
    if (key != null) {
      await box.delete(key);
    }
  }
  Future<void> clearHistory() async {
    await box.clear();
  }

  ValueListenable<Box<String>> listenable() {
    return box.listenable();
  }
}
