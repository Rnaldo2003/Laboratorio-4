import 'package:flutter/material.dart';
import 'news_model.dart';
import 'news_service.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noticias',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NewsHomePage(),
    );
  }
}

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({super.key});

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  late Future<List<Article>> _news;

  @override
  void initState() {
    super.initState();
    _news = NewsService.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Últimas Noticias')),
      body: FutureBuilder<List<Article>>(
        future: _news,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay noticias disponibles'));
          } else {
            final articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: article.urlToImage != ''
                        ? Image.network(article.urlToImage, width: 100, fit: BoxFit.cover)
                        : null,
                    title: Text(article.title),
                    subtitle: Text(article.description),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
