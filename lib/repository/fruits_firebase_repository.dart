import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:w8/repository/fruits_repository.dart';

import '../DTO/fruits_dto.dart';
import '../model/fruits.dart';

class FruitsFirebaseRepository extends FruitRepository {
  static const String baseUrl = '';
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
  Future<List<Fruit>> getFruit() async {
    Uri uri = Uri.parse(allFruitsUrl);
    final http.Response response = await http.get(uri);

    // Handle errors
    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception('Failed to load');
    }

    // Return all users
    final data = json.decode(response.body) as Map<String, dynamic>?;

    if (data == null) return [];
    return data.entries
        .map((entry) => FruitsDto.fromJson(entry.key, entry.value))
        .toList();
  }
}
