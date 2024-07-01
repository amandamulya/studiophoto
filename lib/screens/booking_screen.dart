import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'order_detail_screen.dart'; // Import OrderDetailScreen

class BookingScreen extends StatefulWidget {
  final String selectedPackage;
  final String category;

  BookingScreen({required this.selectedPackage, required this.category});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _eventDateController = TextEditingController();
  final _bookingDateController = TextEditingController();
  final _eventTimeController = TextEditingController();

  File? _image;
  static final List<String> _bookedDateTimes = []; // List to store booked dates

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _eventDateController.dispose();
    _bookingDateController.dispose();
    _eventTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print('Image selected: ${_image!.path}'); // Debug print
      });
    }
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final formattedTime = picked.format(context);
      setState(() {
        controller.text = formattedTime;
      });
    }
  }

  void _submitBooking() {
    if (_formKey.currentState!.validate()) {
      if (_image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Please upload a screenshot of your transfer')),
        );
        return;
      }

      // Add booked date to the list
      final bookedDateTime =
          '${_eventDateController.text} ${_eventTimeController.text}';

      // Check if the selected date and time is already booked
      if (_bookedDateTimes.contains(bookedDateTime)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'The selected event is already booked, please choose another date/time')),
        );
        return;
      }

      // Add booked date time to the set
      _bookedDateTimes.add(bookedDateTime);

      // Get the values from controllers
      String eventDate = _eventDateController.text;
      String bookingDate = _bookingDateController.text;
      String eventTime = _eventTimeController.text;

      // Navigate to OrderDetailScreen with the booking details
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OrderDetailScreen(
            name: _nameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            eventDate: eventDate,
            bookingDate: bookingDate,
            eventTime: eventTime,
            selectedPackage: widget.selectedPackage,
            category: widget.category,
            imagePath: _image,
          ),
        ),
      );

      print(
          'Navigating to OrderDetailScreen with image: ${_image!.path}'); // Debug print

      // Clear the form
      _formKey.currentState!.reset();
      _eventDateController.clear();
      _bookingDateController.clear();
      _eventTimeController.clear();
      setState(() {
        _image = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking for ${widget.selectedPackage}'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fill in your details:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: widget.selectedPackage,
                decoration: InputDecoration(labelText: 'Package'),
                readOnly: true,
              ),
              SizedBox(height: 8),
              TextFormField(
                initialValue: widget.category,
                decoration: InputDecoration(labelText: 'Category'),
                readOnly: true,
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _eventDateController,
                decoration: InputDecoration(
                  labelText: 'Tanggal Acara',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, _eventDateController),
                  ),
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select the event date';
                  }

                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _bookingDateController,
                decoration: InputDecoration(
                  labelText: 'Tanggal Transfer',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () =>
                        _selectDate(context, _bookingDateController),
                  ),
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select the booking date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _eventTimeController,
                decoration: InputDecoration(
                  labelText: 'Jam Acara',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () => _selectTime(context, _eventTimeController),
                  ),
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select the event time';
                  }

                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Note: Minimum transfer amount is IDR 100.000.',
                style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              SizedBox(height: 16),
              Text(
                'Upload Screenshot of Transfer:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _image == null
                  ? Text('No image selected.')
                  : Image.file(_image!,
                      height: 200, width: 200, fit: BoxFit.cover),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Choose Image'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitBooking,
                child: Text('Submit Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
