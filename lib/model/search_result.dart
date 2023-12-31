import 'package:json_annotation/json_annotation.dart';

part 'search_result.g.dart';

@JsonSerializable()
class SearchResult {
  final List<Item> items;

  SearchResult({required this.items});

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}

@JsonSerializable()
class Item {
  final String full_name;
  final String html_url;
  final Owner owner;
  String? avatarFilePath;

  Item(
      {required this.full_name,
      required this.html_url,
      required this.owner,
      this.avatarFilePath});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          runtimeType == other.runtimeType &&
          avatarFilePath == other.avatarFilePath;

  @override
  int get hashCode => avatarFilePath.hashCode;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Owner {
  final String login;
  final String avatar_url;

  Owner({required this.login, required this.avatar_url});

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerToJson(this);
}
