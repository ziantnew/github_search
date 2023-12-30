// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) => SearchResult(
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      full_name: json['full_name'] as String,
      html_url: json['html_url'] as String,
      owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
      avatarFilePath: json['avatarFilePath'] as String?,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'full_name': instance.full_name,
      'html_url': instance.html_url,
      'owner': instance.owner,
      'avatarFilePath': instance.avatarFilePath,
    };

Owner _$OwnerFromJson(Map<String, dynamic> json) => Owner(
      login: json['login'] as String,
      avatar_url: json['avatar_url'] as String,
    );

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
      'login': instance.login,
      'avatar_url': instance.avatar_url,
    };
