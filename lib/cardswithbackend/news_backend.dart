import 'news_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class NewsBackend extends AbstractNewsRepo {
  @override
  Future<List<Map<String, dynamic>>> fetchNews() async {
    try{
    final response = await http.get(Uri.parse('https://prelab-youcefbelaib4430-2p3gbyy0.leapcell.dev/news.all.get'),
        headers: {'Content-type': 'application/json'});
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load news');
    }
  } catch(e){
    throw Exception('Failed to load news: $e');
  }
  }


}