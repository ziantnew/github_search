import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchFilterStateProvider =
StateNotifierProvider<SearchFilterStateNotifier, Map<String, String>>((ref) {
  return SearchFilterStateNotifier();
});

class SearchFilterStateNotifier extends StateNotifier<Map<String, String>> {
  SearchFilterStateNotifier() : super({
    "sort": 'best match',
  });

  void setValue(String key, String? value) {
    state = Map.from(state)..[key] = value!;
  }
}