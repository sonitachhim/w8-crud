import 'package:flutter/material.dart';
import 'package:w8/async_value.dart';

import '../model/fruits.dart';
import '../repository/fruits_repository.dart';

class FruitProviders extends ChangeNotifier {
  final FruitRepository _repository;
  AsyncValue<List<Fruit>>? fruitsState;

  FruitProviders({required FruitRepository repository}) : _repository = repository;

  FruitProvider(_repository) {
    fetchUsers();
  }
  
  bool get isLoading => fruitsState != null && fruitsState!.state == AsyncValueState.loading;
  bool get hasData => fruitsState != null && fruitsState!.state == AsyncValueState.success;

  void fetchUsers() async {
    try {
      // 1- loading state
      fruitsState = AsyncValue.loading();
      notifyListeners();

      // 2 - Fetch users
      fruitsState = AsyncValue.success(await _repository.getFruits());

      print("SUCCESS: list size ${fruitsState!.data!.length.toString()}");
    
      // 3 - Handle errors
    } catch (error) {
      print("ERROR: $error");
      fruitsState = AsyncValue.error(error);
    }
    notifyListeners();
  }
  void addFruit(String name, double price) async {
    // 1- Call repo to add
    _repository.addFruit(name: name, price: price);

    // 2- Call repo to fetch
    fetchUsers();
  }
}
