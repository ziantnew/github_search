import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:search_api/model/search_request.dart';
import 'package:search_api/model/search_result.dart';
import 'package:search_api/provider/search_provider.dart';
import 'package:search_api/util/loading_dailog.dart';
import 'package:search_api/view/Search/search_item.dart';

class SearchListView extends ConsumerStatefulWidget {
  const SearchListView({super.key});

  @override
  _SearchListViewState createState() => _SearchListViewState();
}

class _SearchListViewState extends ConsumerState<SearchListView>
    with WidgetsBindingObserver,AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  late LoadingDialog loadingDialog;
  double appbarH = 56.0;

  late ScrollController _scrollController;

  late SearchResult searchResult = SearchResult(
    items: [],
  );

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
    ref
        .read(searchProvider.notifier)
        .getRepositoryList(SearchRequest(query: 'dart'))
        .then((value) => setState(() {
              if (value != null) {
                searchResult = value;
              }
            }))
        .catchError((e) {
      _showToast(e.toString());
    });
  }

  _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color(0xff0D5514),
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: RefreshIndicator(
            color: const Color(0xffffdc33),
            onRefresh: () async {
              await getSearchList();
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: searchResult.items != null
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
                                    item: searchResult.items![index],
                                  );
                                },
                                childCount: searchResult.items!.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])
                  : Container(),
            )));
  }
}
