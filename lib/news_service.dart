import 'dart:convert';
import 'package:http/http.dart' as http;
import 'news_model.dart';

class NewsService {
  static const String _apiKey = 'fe282fedb4c24537aacb0b397babc577';
  static const String _url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$_apiKey';

  static Future<List<Article>> fetchNews() async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = data['articles'];
      return articles.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar las noticias');
    }
  }
}
