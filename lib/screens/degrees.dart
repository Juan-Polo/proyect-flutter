import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class MyData extends StatefulWidget {
  @override
  _MyDataState createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {
  List<dynamic> data = [];
  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchData() async {
    final String apiUrl = 'http://127.0.0.1:8000/v1/degrees';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        setState(() {
          data = responseData;
        });
      } else {
        throw Exception('Error al cargar los datos');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Degrees'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orange, width: 4.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['name'] ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8.0),
                Text(item['school_day'] ?? ''),
                SizedBox(height: 4.0),
                Text(item['students'] ?? ''),
              ],
            ),
          );
        },
      ),
    );
  }
}
