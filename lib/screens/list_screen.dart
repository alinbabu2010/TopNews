import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:top_news/data/models/articles.dart';
import 'package:top_news/provider/news_provider.dart';
import 'package:top_news/widgets/article_item.dart';
import 'package:top_news/widgets/error_widget.dart';
import 'package:top_news/widgets/progress_bar.dart';

import '../utils/constants.dart';
import '../utils/dimensions.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({Key? key}) : super(key: key);

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  bool isInitialized = false;

  late final NewsProvider newsProvider;
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      newsProvider = Provider.of<NewsProvider>(context);
      newsProvider.pagingController.addPageRequestListener((page) {
        newsProvider.fetchNews(page);
      });
      isInitialized = true;
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    final pagingController = newsProvider.pagingController;
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.appTitle),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() async {
          // Used this approach instead _pagingController.refresh() to retain data and
          // show refreshIndicator until data loads
          await newsProvider.refresh();
          _scrollToTop();
        }),
        child: PagedListView(
          pagingController: pagingController,
          scrollController: _scrollController,
          padding: const EdgeInsets.only(top: Dimens.listTopPadding),
          builderDelegate: PagedChildBuilderDelegate<Article>(
            itemBuilder: (context, article, index) =>
                ArticleItem(article: article),
            firstPageErrorIndicatorBuilder: (_) => EmptyMsgWidget(
              message: (pagingController.error as Exception).toString(),
            ),
            newPageErrorIndicatorBuilder: (_) => EmptyMsgWidget(
              message: (pagingController.error as Exception).toString(),
            ),
            firstPageProgressIndicatorBuilder: (_) => const ProgressBar(),
            newPageProgressIndicatorBuilder: (_) => const ProgressBar(),
            noItemsFoundIndicatorBuilder: (_) => EmptyMsgWidget(
                message: (pagingController.error as Exception).toString()),
            noMoreItemsIndicatorBuilder: (_) => const Padding(
              padding: EdgeInsets.only(
                top: Dimens.noMoreItemsTopPadding,
                bottom: Dimens.noMoreItemsBottomPadding,
              ),
              child: EmptyMsgWidget(message: Constants.noMoreData),
            ),
          ),
        ),
      ),
    );
  }
}
