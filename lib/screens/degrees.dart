import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class MyData extends StatefulWidget {
  @override
  _MyDataState createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {
  List<dynamic> data = []; // Lista para almacenar los datos recibidos

  @override
  void initState() {
    super.initState();
    fetchData(); // Llama a la función para cargar los datos al iniciar la pantalla
  }

  Future<void> fetchData() async {
    // URL de tu endpoint GET en tu API Laravel
    final String apiUrl = 'http://127.0.0.1:8000/v1/degrees';

    try {
      // Realiza la solicitud GET a la API
      final response = await http.get(Uri.parse(apiUrl));

      // Verifica si la solicitud fue exitosa (código de estado 200)
      if (response.statusCode == 200) {
        // Decodifica la respuesta JSON
        final List<dynamic> responseData = json.decode(response.body);

        setState(() {
          // Actualiza el estado de la lista de datos
          data = responseData;
        });
      } else {
        // Si la solicitud no fue exitosa, muestra un mensaje de error
        throw Exception('Error al cargar los datos');
      }
    } catch (e) {
      // Maneja cualquier error ocurrido durante la solicitud HTTP
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
          crossAxisCount: 2, // Número de columnas en el grid
          crossAxisSpacing: 8.0, // Espacio entre las columnas
          mainAxisSpacing: 8.0, // Espacio entre las filas
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return Container(
            decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.orange, width: 4.0), // Borde naranja
              borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
            ),
            padding: EdgeInsets.all(16.0), // Ajusta el padding del Container
            child: Column(
              mainAxisAlignment: MainAxisAlignment
                  .center, // Centra los elementos verticalmente
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
