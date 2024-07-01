import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  final Function addPhoto;

  FormScreen(this.addPhoto);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredDescription = _descriptionController.text;
    final enteredImageUrl = _imageUrlController.text;

    if (enteredTitle.isEmpty || enteredDescription.isEmpty || enteredImageUrl.isEmpty) {
      return;
    }

    widget.addPhoto(
      enteredTitle,
      enteredDescription,
      enteredImageUrl,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Photo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
              controller: _descriptionController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Image URL'),
              controller: _imageUrlController,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitData,
              child: Text('Add Photo'),
            ),
          ],
        ),
      ),
    );
  }
}
