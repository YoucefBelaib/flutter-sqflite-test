import 'package:async_training/cardswithbackend/news_backend.dart';


abstract class AbstractNewsRepo{
  Future<List<Map<String, dynamic>>> fetchNews();

  static AbstractNewsRepo? _newsInstance;

  static AbstractNewsRepo getInstance(){
    _newsInstance ??= NewsBackend();
    return _newsInstance!; // singleton pattern 
  }
}