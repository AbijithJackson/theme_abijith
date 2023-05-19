import 'package:flutter/material.dart';
import 'package:sqflite_internship/new/model_theme.dart';

import '../helper/sql_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRecord extends StatefulWidget {
  const ProductRecord({Key? key}) : super(key: key);

  @override
  State<ProductRecord> createState() => _ProductRecordState();
}

class _ProductRecordState extends State<ProductRecord> {
  // All journals
  List<Map<String, dynamic>> _productlist = [];

  bool _isLoading = true;

  // This function is used to fetch all data from the database
  void _refreshProducts() async {
    final data = await Helper.getItems();
    setState(() {
      _productlist = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshProducts(); // Loading the diary when the app starts
  }

  final TextEditingController _productnameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _productFormKey = GlobalKey<FormState>();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
          _productlist.firstWhere((element) => element['id'] == id);
      _productnameController.text = existingJournal['productname'];
      _priceController.text = existingJournal['price'];
      _descriptionController.text = existingJournal['description'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // this will prevent the soft keyboard from covering the text fields
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Form(
                key: _productFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (_productnameController.text == '') {
                          return "Please enter product name";
                        }
                        return null;
                      },
                      controller: _productnameController,
                      decoration:
                          const InputDecoration(hintText: 'Product Name'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (_priceController.text == '') {
                          return "Please enter price";
                        }
                        return null;
                      },
                      controller: _priceController,
                      decoration: const InputDecoration(hintText: 'Price'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (_descriptionController.text == '') {
                          return "Please enter description";
                        }
                        return null;
                      },
                      controller: _descriptionController,
                      decoration:
                          const InputDecoration(hintText: 'Description'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // Save new journal

                        if (_productFormKey.currentState!.validate()) {
                          if (id == null) {
                            await _addItem();
                            print(
                                "${_productnameController.text}, ${_descriptionController.text}, ${_priceController.text}");
                          }

                          if (id != null) {
                            await _updateItem(id);
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Data Processing")));
                          Navigator.of(context).pop();
                        }

                        // Clear the text fields
                        _productnameController.text = '';
                        _descriptionController.text = '';
                        _priceController.text = '';
                        // Close the bottom sheet
                        // Navigator.of(context).pop();
                      },
                      child: Text(
                          id == null ? 'Create New Product' : 'Update Product'),
                    )
                  ],
                ),
              ),
            ));
  }

// Insert a new journal to the database
  Future<void> _addItem() async {
    await Helper.createItem(_productnameController.text, _priceController.text,
        _descriptionController.text);
    _refreshProducts();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await Helper.updateItem(id, _productnameController.text,
        _priceController.text, _descriptionController.text);
    _refreshProducts();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await Helper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
    _refreshProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ModelTheme themeNotifier, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Product Details"),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                      child: ListTile(
                        title: Text(themeNotifier.isDark ? "Dark Mode" : "Light Mode"),
                    leading: IconButton(
                        icon: Icon(themeNotifier.isDark
                            ? Icons.nightlight_round
                            : Icons.wb_sunny),
                        onPressed: () {
                          themeNotifier.isDark
                              ? themeNotifier.isDark = false
                              : themeNotifier.isDark = true;
                        }),

                  )),
                  PopupMenuItem(
                      child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  )),
                  PopupMenuItem(
                      child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                  )),
                ],
              )
            ],
          ),
          body: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: _productlist.length,
                  itemBuilder: (context, index) {
                    final item = _productlist[index];
                    return Dismissible(
                      onDismissed: (direction) {
                        // Remove the item from the data source.
                        setState(() {
                          _deleteItem(_productlist[index]['id']);
                          _productlist.removeAt(index);
                        });

                        // Then show a snackbar.
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$item dismissed')));
                      },
                      // Show a red background as the item is swiped away.
                      background: Container(color: Colors.red),
                      key: Key(item.toString()),
                      child: Card(
                        color: Colors.orange[200],
                        margin: const EdgeInsets.all(15),
                        child: ListTile(
                            title: Text(_productlist[index]['productname']),
                            subtitle: Text(_productlist[index]['price']),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _showForm(_productlist[index]['id']),
                            )),
                      ),
                    );
                  }),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => _showForm(null),
          ),
        );
      },
    );
  }
}
