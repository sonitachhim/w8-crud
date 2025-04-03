import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:w8/repository/fruits_repository.dart';

import '../DTO/fruits_dto.dart';
import '../model/fruits.dart';

class FruitsFirebaseRepository extends FruitRepository {
  static const String baseUrl =
      'https://fruits-4acd2-default-rtdb.firebaseio.com';
  static const String fruitsCollection = "fruits";
  static const String allFruitsUrl = '$baseUrl/$fruitsCollection.json';

  @override
  Future<Fruit> addFruit({required String name, required double price}) async {
    Uri uri = Uri.parse(allFruitsUrl);

    // Create a new data
    final newFruitData = {'name': name, 'price': price};
    final http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newFruitData),
    );

    // Handle errors
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to add user');
    }

    // Firebase returns the new ID in 'name'
    final newId = json.decode(response.body)['name'];

    // Return created user
    return Fruit(id: newId, name: name, price: price);
  }

  @override
  Future<List<Fruit>> getFruits() async {
    Uri uri = Uri.parse(allFruitsUrl);
    final http.Response response = await http.get(uri);

    // Handle errors
    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception('Failed to load');
    }

    // Return all users
    final decoded = json.decode(response.body);

    //handle null
    if (decoded == null) {
      return [];
    }

    if (decoded is Map<String, dynamic>) {
      return decoded
          .entries
          .map((entry) => FruitsDto.fromJson(entry.key.toString(), entry.value))
          .toList();
    } else {
      throw Exception("Unexpected data format from Firebase");
    }
  }
}
