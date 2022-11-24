import 'package:flutter/material.dart';
import 'package:flutter_hive_encrypt/storage/adapter/user.dart';
import 'package:flutter_hive_encrypt/storage/storage.dart';

import 'configs/hive_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final storage = Storage();
  int _counter = 0;

  void setUser() {
    final user = User();
    user.username = 'teste@teste.com.br';
    user.password = 'teste123456';
    user.token = '4967370d-3565-417a-8f0a-17bac443a3e0';

    storage.write('user', user);
  }

  void getUser() async {
    final user = await storage.read('user');
    if (!(user == null)) {
      debugPrint(user.toString());
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: setUser,
              child: const Text("Save storage"),
            ),
            ElevatedButton(
              onPressed: getUser,
              child: const Text("Load storage"),
            ),
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
