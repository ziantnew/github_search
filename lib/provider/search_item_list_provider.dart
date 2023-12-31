import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchItemListProvider = StateNotifierProvider<SearchItemListNotifier, bool>(
      (ref) => SearchItemListNotifier(),
);

class SearchItemListNotifier extends StateNotifier<bool> {
  SearchItemListNotifier() : super(false);

  void saveSearchItemList(bool bool) {
    state = bool;
  }
}