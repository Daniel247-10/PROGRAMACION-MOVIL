import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  // Caso 1: pokémon que SÍ existe
  await buscarPokemon('pikachu');

  print('---');

  // Caso 2: pokémon que NO existe
  await buscarPokemon('pokemonfalso');
}

Future<void> buscarPokemon(String nombre) async {
  final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$nombre');

  try {
    final response = await http.get(url);

    // ---- Éxito (200) ----
    if (response.statusCode == 200) {
      final datos = jsonDecode(response.body);

      print('Nombre: ${datos['name']}');
      print('Altura: ${datos['height']}');
      print('Peso: ${datos['weight']}');

      // Extraer los tipos
      print('Tipos:');
      for (var tipo in datos['types']) {
        print('- ${tipo['type']['name']}');
      }
    }

    // ---- No encontrado (404) ----
    else if (response.statusCode == 404) {
      print('El pokémon no fue encontrado.');
    }

    // ---- Cualquier otro error ----
    else {
      print('Error. Código: ${response.statusCode}');
    }
  } catch (e) {
    print('Error de conexión: $e');
  }
}