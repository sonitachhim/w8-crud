class Fruit {
  final String id;
  final String name;
  final double price;

  Fruit({required this.id, required this.name, required this.price});

  @override
  bool operator ==(Object other) {
    //checking if other is fruit and id other = id fruit
    return other is Fruit && other.id == id;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode ^ id.hashCode;
}
