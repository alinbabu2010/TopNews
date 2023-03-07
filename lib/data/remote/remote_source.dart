import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart';

import '../models/error_response.dart';
import '../models/news_exception.dart';
import '../models/news_response.dart';

class NetworkDataSource {
  static const _authority = "newsapi.org";
  static const _path = "/v2/top-headlines";

  Future<NewsResponse> fetchNews(int page) async {
    try {
      final queryParameters = {
        "language": "en",
        "pageSize": "10",
        "page": "$page"
      };
      final uri = Uri.https(_authority, _path, queryParameters);
      final response = await get(
        uri,
        headers: {"Authorization": "19b71eb781b0404b93feafc1badf4324"},
      );
      if (response.statusCode >= HttpStatus.badRequest) {
        final errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
        throw NewsException(errorResponse.message);
      } else {
        final newsResponse = NewsResponse.fromJson(jsonDecode(response.body));
        return Future.value(newsResponse);
      }
    } catch (error) {
      rethrow;
    }
  }
}
