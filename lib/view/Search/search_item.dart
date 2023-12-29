import 'package:flutter/material.dart';
import 'package:search_api/model/search_result.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchItem extends StatelessWidget {
  final Item item;

  const SearchItem({
    Key? key,
    required this.item,
  }) : super(key: key);

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
                  child: SizedBox(
                    width: 40,
                    height: 40, // Adjust the width and height as needed
                    child: item.owner.avatar_url.isNotEmpty == true
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
                        item.full_name.isNotEmpty == true
                            ? item.full_name
                            : "undefined",
                        style: const TextStyle(
                          color: Color(0xff808080),
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          fontFamily: "Pretender",
                        ),
                      ),
                      subtitle: item.html_url.isNotEmpty == true
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: GestureDetector(
                                onTap: () async {
                                  if (await canLaunch(item.html_url)) {
                                    await launch(item.html_url);
                                  } else {
                                    // Handle error, e.g., show an error message to the user
                                  }
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
          Container(
            height: 0.2, // Height of the divider line
            color: Colors.grey, // Color of the divider line
          ),
        ],
      ),
    );
  }
}
