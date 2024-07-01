// lib/models/order.dart
import 'dart:io';

class Order {
  final String package;
  final String category;
  final String name;
  final String email;
  final String phone;
  final String eventDate;
  final String bookingDate;
  final File transferScreenshot;

  Order({
    required this.package,
    required this.category,
    required this.name,
    required this.email,
    required this.phone,
    required this.eventDate,
    required this.bookingDate,
    required this.transferScreenshot,
  });
}
