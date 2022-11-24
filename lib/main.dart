import 'package:flutter/material.dart';
import 'package:flutter_hive_encrypt/storage/model/data.dart';
import 'package:flutter_hive_encrypt/storage/core/secure_storage.dart';
import 'package:flutter_hive_encrypt/storage/key/encrypt_key%20copy.dart';

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
  const MyHomePage({
    super.key, 
    required this.title
    });
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final storage = SecureStorage(EncryptKey());
  String textJson= '';

  void setUser() async {
    // final user = User();
    // user.username = 'teste@teste.com.br';
    // user.password = 'teste123456';
    // user.token = '4967370d-3565-417a-8f0a-17bac443a3e0';
    final obj = Data();
    obj.birthday = DateTime(1987, 5, 21);
    obj.old = 35;
    obj.live = true;    
    await storage.write('data', obj);
  }

  void getUser() async {
    final exist = await storage.contains('data');
    if(!exist) return;
    final obj = await storage.read<Data>('data');
    debugPrint(obj.toString());
    setState(() {
      textJson = obj.toString();
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
              'Json do objeto salvo',
            ),
            Text(
              textJson,
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
    );
  }
}
