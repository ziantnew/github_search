import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:search_api/dio/dio.dart';
import 'package:search_api/model/search_result.dart';
part 'search_repository.g.dart';

final searchRepositoryProvider = Provider<SearchRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);
    return SearchRepository(dio, baseUrl: 'https://api.github.com');
  },
);

@RestApi()
abstract class SearchRepository {
  factory SearchRepository(Dio dio, {String baseUrl}) = _SearchRepository;
  @GET('/search/repositories')
  Future<SearchResult> getRepositoryList({
    @Query("q") String? query,
  });

}
