import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:business_news/app/network/api_client.dart';
import 'package:business_news/features/news/models/news_model.dart';

// ignore: one_member_abstracts
abstract class NewsRepository {
  Future<List<NewsModel>?> getNewsDetails({required int page});
}

class NewsRepositoryImpl implements NewsRepository {
  final _apiClient = ApiClient();

  @override
  Future<List<NewsModel>?> getNewsDetails({required int page}) async {
    final data = await _apiClient.get(
      //only displaying business news
      'https://newsapi.org/v2/top-headlines?country=us&category=business&page=$page&pageSize=30&apiKey=${dotenv.env['api_key']}',
    );
    final listOfNews = data['articles'] as List<dynamic>;
    return listOfNews
        .map((dynamic e) => NewsModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
