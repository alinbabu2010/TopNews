import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:top_news/data/models/articles.dart';
import 'package:top_news/data/remote/remote_source.dart';

class NewsProvider with ChangeNotifier {
  final _networkDataSource = NetworkDataSource();

  final _pageSize = 12;

  final PagingController<int, Article> _pagingController =
      PagingController(firstPageKey: 1);

  PagingController<int, Article> get pagingController => _pagingController;

  List<Article>? get _fetchedArticles => _pagingController.itemList;

  /// To fetch news from API and set state
  Future<void> fetchNews(int page) async {
    try {
      final newItems = await _networkDataSource.fetchNews(page, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      final nextPageKey = isLastPage ? null : (page + 1);
      final fetchedArticles = page == 1 ? [] : _fetchedArticles ?? [];
      _pagingController.value = PagingState(
          itemList: [...fetchedArticles, ...newItems],
          nextPageKey: nextPageKey);
    } catch (error) {
      _pagingController.value = PagingState(error: error);
    }
    _pagingController.notifyListeners();
  }

  /// To refresh news from API by calling [fetchNews] with initial page
  Future<void> refresh() async {
    await fetchNews(1);
  }
}
