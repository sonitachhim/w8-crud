import 'package:w8/model/fruits.dart';

class FruitsDto {
  static Fruit fromJson(String id, Map<String, dynamic> json) {
    return Fruit(id: id, name: json['name'], price: json'[price]');
  }

  static Map<String, dynamic> toJson(Fruit fruit) {
    return {'name': fruit.name, 'price': fruit.price};
  }
}