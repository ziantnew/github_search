// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchRequest _$SearchRequestFromJson(Map<String, dynamic> json) =>
    SearchRequest(
      query: json['query'] as String,
      per_page: json['per_page'] as int?,
      page: json['page'] as int?,
      sort: json['sort'] as String,
    );

Map<String, dynamic> _$SearchRequestToJson(SearchRequest instance) =>
    <String, dynamic>{
      'query': instance.query,
      'per_page': instance.per_page,
      'page': instance.page,
      'sort': instance.sort,
    };
