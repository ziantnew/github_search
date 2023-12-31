import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_api/model/search_request.dart';
import 'package:search_api/model/search_result.dart';
import 'package:search_api/provider/search_provider.dart';
import 'package:search_api/util/custom_toast.dart';
import 'package:search_api/util/loading_dailog.dart';
import 'package:search_api/util/util.dart';
import 'package:search_api/view/Search/filter_select_box.dart';
import 'package:search_api/view/Search/search_item.dart';

class SearchListView extends ConsumerStatefulWidget {
  const SearchListView({super.key});

  @override
  _SearchListViewState createState() => _SearchListViewState();
}

class _SearchListViewState extends ConsumerState<SearchListView>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late LoadingDialog loadingDialog;
  double appbarH = 56.0;

  late ScrollController _scrollController;

  late SearchResult searchResult = SearchResult(
    items: [],
  );

  int page = 1;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    WidgetsBinding.instance!.addObserver(this);
    loadingDialog = LoadingDialog(context: context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initializeState();
    });
  }

  void initializeState() async {
    await getSearchList();
  }

  @override
  void dispose() {
    if (!mounted) {
      return;
    }
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  Future<void> getSearchList({int workLocationId = 0}) async {
    loadingDialog.show();
    ref
        .read(searchProvider.notifier)
        .getRepositoryList(
            SearchRequest(query: 'dart', per_page: 100, page: page))
        .then((value) => setState(() {
              loadingDialog.hide();
              if (value != null) {
                searchResult = value;
              }
            }))
        .catchError((e) {
      loadingDialog.hide();
      CustomToast.showToast(
        message: e.toString(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterSelectBox(onChanged: (value) {
            print("filter_value::$value");
          }),
          Expanded(
            child: RefreshIndicator(
                color: const Color(0xffffdc33),
                onRefresh: () async {
                  await getSearchList();
                },
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: Utils.isNotNullAndNotEmpty(searchResult.items)
                      ? Stack(children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: CustomScrollView(
                              controller: _scrollController,
                              slivers: [
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      return SearchItem(
                                        item: searchResult.items[index],
                                      );
                                    },
                                    childCount: searchResult.items.length,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ])
                      : Container(),
                )),
          ),
        ],
      ),
    );
  }
}
