import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Practice',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Citys Perú'),
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
  List _dataList = [];

  void _incrementCounter() async {
    final data =
        await http.get(Uri.parse('https://api.npoint.io/5ecaa20ebea4d86084e5'));
    setState(() {
      _dataList = jsonDecode(data.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        width: 200,
        backgroundColor: Colors.redAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "IngNex",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Divider(),
            Text("INICIO", style: TextStyle(fontSize: 16, color: Colors.white)),
          ],
        ),
      ),
      body: Center(
        child: PageView.builder(
          itemCount: _dataList.length,
          itemBuilder: (context, index) {
            final item = _dataList[index];
            final image = item["image"];
            final title = item['name'];
            final description = item['description'];
            //Clase
            final city =
                City(image: image, title: title, description: description);
            return HomeItem(city: city);
          },
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

class HomeItem extends StatelessWidget {
  const HomeItem({super.key, required this.city});

  final City city;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        elevation: 20,
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(city.image),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                city.title,
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                city.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class City {
  City({required this.image, required this.title, required this.description});
  final String image;
  final String title;
  final String description;
}
