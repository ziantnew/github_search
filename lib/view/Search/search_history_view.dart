import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_api/model/search_result.dart';
import 'package:search_api/provider/search_item_list_provider.dart';
import 'package:search_api/util/loading_dailog.dart';
import 'package:search_api/util/local_storage.dart';
import 'package:search_api/util/util.dart';
import 'package:search_api/view/Search/search_item.dart';

class SearchHistoryView extends ConsumerStatefulWidget {
  const SearchHistoryView({super.key});

  @override
  _SearchHistoryViewState createState() => _SearchHistoryViewState();
}

class _SearchHistoryViewState extends ConsumerState<SearchHistoryView>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late LoadingDialog loadingDialog;
  double appbarH = 56.0;

  late ScrollController _scrollController;

  late List<Item> historyItemList = [];

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
    await getSearchHistoryList();
  }

  @override
  void dispose() {
    if (!mounted) {
      return;
    }
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  Future<void> getSearchHistoryList() async {
    var historyList =
        await LocalStorage.getRepositoryList(LocalStorage.repository);
    if (Utils.isNotNullAndNotEmpty(historyList)) {
      Set<Item> uniqueItemsSet = {};
      List<Item> uniqueHistoryItemList = historyList!.where((item) {
        return uniqueItemsSet.add(item);
      }).toList();

      setState(() {
        historyItemList = uniqueHistoryItemList;
      });
      ref.read(searchItemListProvider.notifier).saveSearchItemList(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final saveItem = ref.watch(searchItemListProvider);
    if (saveItem) {
      getSearchHistoryList();
    }
    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: RefreshIndicator(
            color: const Color(0xffffdc33),
            onRefresh: () async {
              await getSearchHistoryList();
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Utils.isNotNullAndNotEmpty(historyItemList)
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
                                    item: historyItemList[index],
                                    historyCheck: true,
                                  );
                                },
                                childCount: historyItemList.length,
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
