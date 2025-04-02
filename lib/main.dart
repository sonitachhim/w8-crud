import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'repository/fruits_firebase_repository.dart';
import 'repository/fruits_repository.dart';
import 'provider/fruit_providers.dart';
import 'screen/fruits_screen.dart';

void main() async {
  final FruitRepository fruitRepository = FirebaseFruitRepository();

  runApp(
    ChangeNotifierProvider(
      create: (context) => Fruitprovider(fruitRepository),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: const App()),
    ),
  );
}
