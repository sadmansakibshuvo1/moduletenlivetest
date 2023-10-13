import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyScreen(),
    );
  }
}

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
  List<bool> selectedItems = List.generate(5, (index) => false);

  // Function to toggle item selection
  void toggleItemSelection(int index) {
    setState(() {
      selectedItems[index] = !selectedItems[index];
    });
  }

  // Function to get selected items
  List<String> getSelectedItems() {
    List<String> selected = [];
    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i]) {
        selected.add(items[i]);
      }
    }
    return selected;
  }

  // Function to show the selected items dialog
  void showSelectedItemsDialog(BuildContext context) {
    List<String> selected = getSelectedItems();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selected Items'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Number of selected items: ${selected.length}'),
              SizedBox(height: 16),
              Text('Selected items:'),
              for (String item in selected)
                Text('- $item'),
            ],
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selection Screen'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            onTap: () {
              toggleItemSelection(index);
            },
            tileColor: selectedItems[index] ? Colors.blue : Colors.transparent,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSelectedItemsDialog(context);
        },
        child: Icon(Icons.check),
        tooltip: 'Show Selected Items',
      ),
    );
  }

  FlatButton({required Null Function() onPressed, required Text child}) {}
}
