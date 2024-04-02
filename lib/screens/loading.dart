import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: Image.asset(
          "assets/images/logo1.png",
          height: 200,
        ),
        title: const Text("Our Little World"),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: const [Icon(Icons.search), Icon(Icons.person)],
      ),
      body: const UserList(),
    );
  }
}

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final userData = snapshot.data![index];
                return ListTile(
                  title: Text(userData['name'] ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lastname: ${userData['lastname'] ?? ''}'),
                      Text('Email: ${userData['email'] ?? ''}'),
                      Text('Password: ${userData['password'] ?? ''}'),
                      Image.network(
                        'http://127.0.0.1:8000/${userData['image']}' ?? '',
                        width: 100, // Ajusta el ancho según tus necesidades
                        height: 100, // Ajusta el alto según tus necesidades
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        }
      },
    );
  }

  Future<List<dynamic>> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('http://127.0.0.1:8000/v1/users'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Error en la solicitud HTTP: ${response.statusCode}');
        return []; // Devuelve una lista vacía en caso de error
      }
    } catch (e) {
      print('Error al realizar la solicitud HTTP: $e');
      return []; // Devuelve una lista vacía en caso de error
    }
  }
}
