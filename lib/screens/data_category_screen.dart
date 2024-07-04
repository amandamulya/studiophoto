import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../widgets/drawer.dart';

class DataCategoryScreen extends StatefulWidget {
  @override
  _DataCategoryScreenState createState() => _DataCategoryScreenState();
}

class _DataCategoryScreenState extends State<DataCategoryScreen> {
  List<Map<String, String>> categories = [
    {
      'name': 'Pre Wedding',
      'description':
          'This is a detailed description of Studio Photo 1, including various features and highlights of the studio',
      'image': 'assets/images/prewedding.jpeg',
    }
  ];

  final _categoryNameController = TextEditingController();
  final _categoryDescriptionController = TextEditingController();
  File? _pickedImage;
  int? _editingIndex;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  void _addOrUpdateCategory() {
    if (_categoryNameController.text.isEmpty ||
        _categoryDescriptionController.text.isEmpty ||
        _pickedImage == null) {
      return;
    }
    if (_editingIndex == null) {
      setState(() {
        categories.add({
          'name': _categoryNameController.text,
          'description': _categoryDescriptionController.text,
          'image': _pickedImage!.path,
        });
      });
    } else {
      setState(() {
        categories[_editingIndex!] = {
          'name': _categoryNameController.text,
          'description': _categoryDescriptionController.text,
          'image': _pickedImage!.path,
        };
        _editingIndex = null;
      });
    }
    _categoryNameController.clear();
    _categoryDescriptionController.clear();
    _pickedImage = null;
    Navigator.of(context).pop();
  }

  void _showAddOrEditCategoryDialog({int? index}) {
    if (index != null) {
      _editingIndex = index;
      _categoryNameController.text = categories[index]['name']!;
      _categoryDescriptionController.text = categories[index]['description']!;
      _pickedImage = File(categories[index]['image']!);
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(index == null ? 'Tambah Kategori' : 'Edit Kategori'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nama Kategori'),
              controller: _categoryNameController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Deskripsi Kategori'),
              controller: _categoryDescriptionController,
            ),
            SizedBox(height: 10),
            _pickedImage == null
                ? Text('No Image Selected')
                : Image.file(
                    _pickedImage!,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
            TextButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Batal'),
            onPressed: () {
              _categoryNameController.clear();
              _categoryDescriptionController.clear();
              _pickedImage = null;
              _editingIndex = null;
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: Text(index == null ? 'Tambah' : 'Update'),
            onPressed: _addOrUpdateCategory,
          ),
        ],
      ),
    );
  }

  void _deleteCategory(int index) {
    setState(() {
      categories.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Kategori'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddOrEditCategoryDialog(),
          ),
        ],
      ),
      drawer: AppDrawer(
        userRole: 'admin',
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (ctx, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: FileImage(File(categories[index]['image']!)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          categories[index]['name']!,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          categories[index]['description']!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () =>
                                  _showAddOrEditCategoryDialog(index: index),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteCategory(index),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
