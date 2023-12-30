import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/search_result.dart';

class LocalStorage {
  static const repository = "REPOSITORY";

  static Future<void> saveRepositoryList(String key, List<Item> items) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList = items.map((item) => json.encode(item.toJson())).toList();
    await prefs.setStringList(key.toString(), jsonList);
  }

  static Future<List<Item>?> getRepositoryList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonStringList = prefs.getStringList(key.toString());

    if (jsonStringList != null) {
      List<Item> repoList = jsonStringList.map((jsonString) {
        Map<String, dynamic> jsonMap = json.decode(jsonString);
        return Item.fromJson(jsonMap);
      }).toList();

      return repoList;
    } else {
      return null;
    }
  }

  static Future<void> addItemToRepositoryList(String key, Item newItem) async {
    List<Item>? existingList = await getRepositoryList(key);
    if (existingList != null) {
      existingList.add(newItem);
      await saveRepositoryList(key, existingList);
    } else {
      // If the list doesn't exist yet, create a new list with the new item
      await saveRepositoryList(key, [newItem]);
    }
  }
}
