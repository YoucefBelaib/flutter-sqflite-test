import 'package:flutter/material.dart';
import './dbabstract.dart';
import './login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Map>> data;
  late AbstractLoginRepo repo;

  @override
  void initState() {
    super.initState();
    repo = AbstractLoginRepo.getInstance();
    data = repo.getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login History Page'),
      ),
      body: Center(
        child: Padding(padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('Home Screen'),
                ElevatedButton(onPressed: () async {
                  await repo.deleteAllLogin();
                  setState(() {
                    data = repo.getData();
                  });
                }, child: const Text('Delete All')),
                ElevatedButton(onPressed:() {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Login())
                  );
                }, child: const Text('Log Out'))
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Map>>(
                future: data,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No login history found.');
                  } else {
                    final loginData = snapshot.data!;
                    return ListView.builder(
                      itemCount: loginData.length,
                      itemBuilder: (context, index) {
                        final item = loginData[index];
                        return ListTile(
                          title: Text('Username: ${item['username']}'),
                          subtitle: Text('Date: ${item['date']}'),
                          trailing: GestureDetector(
                                    child: Icon(Icons.delete,),
                                    onTap: () async {
                            await repo.deleteLogin(item['id'] as int);
                            setState(() {
                              data = repo.getData();
                            });
                          },
                        ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}