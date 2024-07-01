// lib/models/booking.dart
class Booking {
  final int? id;
  final String name;
  final String email;
  final String phone;
  final String eventDate;
  final String bookingDate;
  final String selectedPackage;
  final String category;
  final String imagePath;

  Booking({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.eventDate,
    required this.bookingDate,
    required this.selectedPackage,
    required this.category,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'eventDate': eventDate,
      'bookingDate': bookingDate,
      'selectedPackage': selectedPackage,
      'category': category,
      'imagePath': imagePath,
    };
  }
}
