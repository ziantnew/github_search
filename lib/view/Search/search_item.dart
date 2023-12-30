import 'package:flutter/material.dart';
import 'package:search_api/model/search_result.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:search_api/util/local_storage.dart';
import 'package:search_api/util/util.dart';
import 'package:search_api/view/Search/image_file_path.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchItem extends StatelessWidget {
  final Item item;
  bool? historyCheck;

  SearchItem({Key? key, required this.item, this.historyCheck})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 110,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: historyCheck == true
                      ? ImageFilePath(filePath: item.avatarFilePath.toString())
                      : SizedBox(
                          width: 40,
                          height: 40, // Adjust the width and height as needed
                          child: item.owner.avatar_url.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: item.owner.avatar_url,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )
                              : Container(),
                        ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: ListTile(
                      title: Text(
                        item.full_name.isNotEmpty
                            ? item.full_name
                            : "undefined",
                        style: const TextStyle(
                          color: Color(0xff808080),
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          fontFamily: "Pretender",
                        ),
                      ),
                      subtitle: item.html_url.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: GestureDetector(
                                onTap: () async {
                                  if (item.owner.avatar_url != null &&
                                      item.owner.avatar_url.isNotEmpty) {
                                    print("GestureDetector");
                                    String? filePath =
                                        await Utils.downloadAndSaveImage(
                                            item.owner.avatar_url);
                                    if (filePath != null) {
                                      item.avatarFilePath = filePath;

                                      Item newItem = item; // create a new Item
                                      await LocalStorage
                                          .addItemToRepositoryList(
                                              LocalStorage.repository, newItem);
                                    }
                                  }

                                  launchUrl(
                                    Uri.parse(item.html_url),
                                  );
                                },
                                child: Text(
                                  item.html_url,
                                  style: const TextStyle(
                                    color: Color(0xff9B9996),
                                    fontSize: 16,
                                    fontFamily: "Pretender",
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
