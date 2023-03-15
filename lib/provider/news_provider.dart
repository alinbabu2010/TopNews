import 'package:flutter/material.dart';
import 'package:top_news/data/models/articles.dart';
import 'package:top_news/data/remote/remote_source.dart';
import 'package:top_news/provider/news_state.dart';

class NewsProvider with ChangeNotifier {
  final _networkDataSource = NetworkDataSource();

  final _pageSize = 12;

  NewsState _newsState = NewsState();

  NewsState get newsState => _newsState;

  List<Article>? get _fetchedArticles => _newsState.itemList;

  Future<void> fetchNews(int page) async {
    try {
      final newItems = await _networkDataSource.fetchNews(page, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      final nextPageKey = isLastPage ? null : (page + 1);
      final fetchedArticles = page == 1 ? [] : _fetchedArticles ?? [];
      _newsState = _newsState.copyWith(
          itemList: [...fetchedArticles, ...newItems],
          nextPageKey: nextPageKey);
    } catch (error) {
      _newsState = _newsState.copyWith(error: error);
    }
    notifyListeners();
  }

  Future<void> refresh() async {
    await fetchNews(1);
  }
}
