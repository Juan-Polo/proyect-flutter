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
       height: 100.0,
          
        ),
        title: const Text("Our Little World"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 152, 0),
        actions: const [Icon(Icons.search), Icon(Icons.person)],
      ),
      body: const UserList(),

      bottomNavigationBar: MyFooter(),

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
      
                  title:Text('Nombre: ${userData['name'] ?? ''}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Apellido: ${userData['lastname'] ?? ''}'),
                      Text('Email: ${userData['email'] ?? ''}'),
                      Text('Password: ${userData['password'] ?? ''}'),
                      
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






class MyFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0, // Define la altura deseada
      padding: EdgeInsets.all(10.0),
      color: const Color.fromARGB(255, 255, 152, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
      'assets/images/pieniño.png',
      width: 150, // Ancho deseado de la imagen
      height: 150, // Alto deseado de la imagen
    ),
              _buildFooterIcon(Icons.audiotrack),
              _buildFooterIcon(Icons.fingerprint),
              _buildFooterIcon(Icons.call),

              Image.asset(
      'assets/images/pieniña.png',
      width: 150, // Ancho deseado de la imagen
      height: 150, // Alto deseado de la imagen
    ),
            ],

          ),
           const Text(
            'Copyright ©2024, All Rights Reserved.',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 12.0,
              color: Color(0xFF162A49),
            ),
          ),
          const Text(
            'Powered by Your Company',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 12.0,
              color: Color(0xFF162A49),
            ),
          ),

           
        ],
      ),
    );
  }

  Widget _buildFooterIcon(IconData iconData) {
    return Container(
      height: 45.0,
      width: 45.0,
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: IconButton(
          icon: Icon(iconData, size: 20.0,),
          color: Color(0xFF162A49),
          onPressed: () {},
        ),
      ),
    );
  }
}
