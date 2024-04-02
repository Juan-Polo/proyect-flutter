// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'dart:convert';

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<dynamic> _data = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     try {
//       final response = await Dio().get('https://pokeapi.co/api/v2/pokemon/1');

//       setState(() {
//         _data = json.decode(response.data);
//       });
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter API Demo'),
//       ),
//       body: Center(
//         child: _data.isEmpty
//             ? CircularProgressIndicator()
//             : ListView.builder(
//                 itemCount: _data.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(_data[index]['title']),
//                     subtitle: Text(_data[index]['description']),
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }






// class BodyWidget extends StatefulWidget {
//   const BodyWidget({super.key});

//   @override
//   State<BodyWidget> createState() => _BodyWidgetState();
// }

// class _BodyWidgetState extends State<BodyWidget> {
//   dynamic pokemon;

//   @override
//   void initState() {
//     super.initState();
//     getPokemon();
//   }

//   Future<void> getPokemon() async {
//     // final response = await Dio().get('https://pokeapi.co/api/v2/pokemon/1');
// // http://127.0.0.1:8000/v1/users
// // https://pokeapi.co/api/v2/pokemon/1
//     // response;
//     // setState(() {
//     //   pokemon = response.data;
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Text(pokemon?.toString() ?? "No data"),
//     ]);
//   }
// }

// class TablaUsuarios extends StatelessWidget {
//   const TablaUsuarios({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//             padding: EdgeInsets.all(15.0),
//             child: Image.asset("assets/images/logo1.png")),
//       ],
//     );
//   }
// }
