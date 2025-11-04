import 'package:flutter/material.dart';
import 'news_service.dart';


class aCard extends StatelessWidget {
  const aCard({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            width: double.infinity,
            height: 150,
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
                SizedBox(width: 20),
                Expanded(child: 
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['title'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), 
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                    SizedBox(height: 10),
                    Text(data['description'] ?? 'No description', style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,),
              ]))
              ],
            ),
          ),
        );}
  }


class Cards extends StatefulWidget{
  const Cards({super.key});

  @override
  State<Cards> createState() => _CardsState();
}


class _CardsState extends State<Cards>{
  late Future<List<Map<String, dynamic>>> news;
  late AbstractNewsRepo newsRepo;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsRepo = AbstractNewsRepo.getInstance();
    news = newsRepo.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: news,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No news available'));
        }

        // If we have data, let's display the cards
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return aCard(data: snapshot.data![index]);
          },
        );
      },
    );
  }
}

 