import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/fruits.dart';

class FruitsScreen extends StatelessWidget {
  const FruitsScreen({super.key});

  void _onAddPressed(BuildContext context) {
    final Fruitprovider FruitProvider = context.read<Fruitprovider>();
    FruitProvider.addFruit("banana", 12);
  }

  @override
  Widget build(BuildContext context) {
    final fruitProvider = Provider.of<Fruitprovider>(context);

    Widget content = Text('');
    if (fruitProvider.isLoading) {
      content = CircularProgressIndicator();
    } else if (fruitProvider.hasData) {
    List<Fruit> fruits = fruitProvider.fruitsState!.data!;

    if (fruits.isEmpty) {
      content = Text("No data yet");
    } else {
      content = ListView.builder(
        itemCount: fruits.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(fruits[index].name),
          subtitle: Text("${fruits[index].price}"),
          trailing: IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: () => {}),
        ),
      );
    }
  }

  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue,
      actions: [IconButton(onPressed: () => _onAddPressed(context), icon: const Icon(Icons.add))],
    ),
    body: Center(child: content),
  );
}
}