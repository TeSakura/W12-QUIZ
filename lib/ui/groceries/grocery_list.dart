import 'package:flutter/material.dart';
import '../../data/mock_grocery_repository.dart';
import '../../models/grocery.dart';
import 'grocery_form.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  late List<Grocery> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(dummyGroceryItems);
  }

  void onCreate() async {
    // Navigate to the form and await a new Grocery returned by Navigator.pop
    final result = await Navigator.of(
      context,
    ).push<Grocery>(MaterialPageRoute(builder: (ctx) => const NewItem()));

    if (result != null) {
      setState(() {
        _items.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (_items.isNotEmpty) {
      // Display groceries with an Item builder and ListTile
      content = ListView.builder(
        itemCount: _items.length,
        itemBuilder: (ctx, index) => GroceryTile(grocery: _items[index]),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: onCreate, icon: const Icon(Icons.add))],
      ),
      body: content,
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile({super.key, required this.grocery});

  final Grocery grocery;

  @override
  Widget build(BuildContext context) {
    // TODO-2 - Display groceries with an Item builder and  LIst Tile
    return ListTile(
      leading: Container(color: grocery.category.color, width: 15, height: 15),
      title: Text(grocery.name),
      trailing: Text(grocery.quantity.toString()),
    );
  }
}
