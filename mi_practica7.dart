import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  // Probar con id = 5 (existe)
  await obtenerTarea(5);

  print('---');

  // Probar con id = 99999 (no existe → 404)
  await obtenerTarea(99999);
}

Future<void> obtenerTarea(int id) async {
  final url = Uri.parse(
    'https://jsonplaceholder.typicode.com/todos/$id',
  );

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final datos = jsonDecode(response.body);
      print('Título: ${datos['title']}');
      if (datos['completed'] == true) {
        print('Estado: Completada');
      } else {
        print('Estado: Pendiente');
      }
    } else if (response.statusCode == 404) {
      print('La tarea no fue encontrada.');
    } else {
      print('Error. Código: ${response.statusCode}');
    }
  } catch (e) {
    print('Error de conexión: $e');
  }
}