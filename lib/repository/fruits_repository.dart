import '../model/fruits.dart';

abstract class FruitRepository {
  Future<Fruit> addFruit({required String name, required double price});
  Future<List<Fruit>> getFruits();
}
