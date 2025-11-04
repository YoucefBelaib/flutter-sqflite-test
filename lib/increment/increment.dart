import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Increment extends StatefulWidget{
  const Increment({super.key});

  @override
  State<Increment> createState() => _IncrementState();


}
class _IncrementState extends State<Increment>{
  int _counter = 0;
  late final SharedPreferences _prefs;

  void _incrementCounter(){
    _counter++;
    _prefs.setInt('counter', _counter);
    setState(() {});
  }

  void _resetCounter(){
    _counter = 0;
    _prefs.setInt('counter', _counter);
    setState(() {});
  }

  @override
  void initState(){
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async{
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = _prefs.getInt('counter') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Increment App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
            ElevatedButton(onPressed: _resetCounter, child: const Text('Reset Counter')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}