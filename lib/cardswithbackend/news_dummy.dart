import 'news_service.dart';


class NewsDummy extends AbstractNewsRepo {
  @override
  Future<List<Map<String, dynamic>>> fetchNews() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));
    return [
      {
        'title': 'Dummy News 1',
        'subtitle': 'This is a dummy news subtitle 1',
      },
      {
        'title': 'Dummy News 2',
        'subtitle': 'This is a dummy news subtitle 2',
      },
    ];
  }
}
