import 'package:top_news/data/models/articles.dart';

class NewsState {
  NewsState({
    this.itemList,
    this.error,
    this.nextPageKey = 0,
  });

  final List<Article>? itemList;
  final dynamic error;
  final int? nextPageKey;

  NewsState copyWith({
    List<Article>? itemList,
    dynamic error,
    int? nextPageKey,
  }) =>
      NewsState(
        itemList: itemList ?? this.itemList,
        error: error ?? this.error,
        nextPageKey: nextPageKey,
      );
}
