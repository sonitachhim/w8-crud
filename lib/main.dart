import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'repository/fruits_firebase_repository.dart';
import 'repository/fruits_repository.dart';
import 'provider/fruit_providers.dart';
import 'screen/fruits_screen.dart';

void main() async {
  final FruitRepository fruitRepository = FruitsFirebaseRepository();

  runApp(
    ChangeNotifierProvider(
      create: (context) => FruitProviders(repository: fruitRepository),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: const FruitsScreen()),
    ),
  );
}
