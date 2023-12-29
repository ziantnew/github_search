import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_api/model/search_request.dart';
import 'package:search_api/repository/search_repository.dart';
import '../model/search_result.dart';


final searchProvider =
StateNotifierProvider<SearchNotifier, SearchResult?>((ref) {
  final searchRepository = ref.watch(searchRepositoryProvider);

  return SearchNotifier(
    searchRepository: searchRepository,
  );
});

class SearchNotifier extends StateNotifier<SearchResult?> {
  final SearchRepository searchRepository;

  SearchNotifier({
    required this.searchRepository,
  }) : super(null);

  Future<SearchResult?> getRepositoryList(SearchRequest request) async {
    try {
      final results = await searchRepository.getRepositoryList(
        query: request.query,
      );
      return results;
    } catch (error) {
      print("Error fetching results: $error");
      return null;
    }
  }

  void clear() {
    state = null;
  }

  @override
  void dispose() {
    state = null;
    super.dispose();
  }
}
