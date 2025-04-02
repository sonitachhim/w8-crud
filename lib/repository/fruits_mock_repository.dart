import 'package:w8/repository/fruits_repository.dart';

import '../model/fruits.dart';

class FruitsMockRepository extends FruitRepository {
  final List<Fruit> fruits = [];

  @override
  Future<Fruit> addFruit({required String name, required double price}) {
    return Future.delayed(Duration(seconds: 1), () {
      Fruit newFruit = Fruit(id: "0", name: name, price: 15);
      fruits.add(newFruit);
      return newFruit;
    });
  }

  @override
  Future<List<Fruit>> getFruits() {
    return Future.delayed(Duration(seconds: 1), () => fruits);
  }
}
