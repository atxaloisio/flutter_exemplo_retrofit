import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:exemplo_retrofit/api_client.dart';
import 'package:exemplo_retrofit/login.dart';
import 'package:exemplo_retrofit/response_data.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      // final dio = Dio(BaseOptions(contentType: "application/json"));
      // final client = ApiClient(dio);
      // client.getUsers().then((it) => {
        //print(it.data)
        // it.data.forEach((item) => print(item))
        //logger.i(it);
      // });
      postData();
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  FutureBuilder<ResponseData> _buildBody(BuildContext context) {
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<ResponseData>(
      future: client.getUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final ResponseData? posts = snapshot.data;
          return _buildListView(context, posts!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildListView(BuildContext context, ResponseData posts) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: const Icon(
              Icons.account_box,
              color: Colors.green,
              size: 50,
            ),
            title: Text(
              posts.data[index]['name'],
              style: const TextStyle(fontSize: 20),
            ),
            subtitle: Text(posts.data[index]['email']),
          ),
        );
      },
      itemCount: posts.data.length,
    );
  }

  Future<void> postData() async {
    var data = json.encode({"email": "atxaloisio@gmail.com", "password": "Pass4ptec@"});
    var headers = {
  'Content-Type': 'application/json'
};
    Dio dio2 = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:5164',
        connectTimeout: const Duration(milliseconds: 5000) ,
        receiveTimeout: const Duration(milliseconds: 3000) ,
      ),
    );
    try {
      Response response = await dio2.post(
        '/v1/identity/login',
        data: data,
        options: Options(headers: headers)
      );
      print(response.data);
      //var login = parseLogin(response.data);
      var login = Login.fromJson(response.data);
      print(login.toString());
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Login parseLogin(Map<String, dynamic> map) {
    //Map<String, dynamic> map = jsonDecode(responseBody);
    Login login = Login.fromJson(map);
    return login;
  }
}


