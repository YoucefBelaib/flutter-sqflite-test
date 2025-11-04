import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class Login extends StatefulWidget{
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();

}

class _LoginState extends State<Login>{
  
  late final SharedPreferences prefs;
  final TextEditingController _controller = TextEditingController();
  String _username = '';
  @override
  void initState(){
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? '';
    });
    if (_username.isNotEmpty) {
      // Navigate directly to Home
      if (!mounted) {
        return;
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Home(username: _username)),
        );
      });
    }
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Padding(padding: EdgeInsets.all(16.0), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login Screen'),
            SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
              controller: _controller,
            ),
            SizedBox(height: 40),
            ElevatedButton(onPressed: () {
              // Save username to SharedPreferences
                _username = _controller.text;
                prefs.setString('username', _username);
                // Navigate to Home screen
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Home(username: _username)),
                );
              }, child: const Text('Login'))
          ],
        )),
      ),
    );
  }
}