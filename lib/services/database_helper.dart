// lib/services/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/booking.dart';
import '../screens/login_screen.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT NOT NULL,
            password TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE bookings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL,
            phone TEXT NOT NULL,
            eventDate TEXT NOT NULL,
            bookingDate TEXT NOT NULL,
            selectedPackage TEXT NOT NULL,
            category TEXT NOT NULL,
            imagePath TEXT NOT NULL
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            ALTER TABLE users ADD COLUMN role TEXT NOT NULL DEFAULT 'customer'
          ''');
        }
      },
    );
  }

  Future<void> registerUser(String email, String password, String role) async {
    final db = await database;
    await db.insert(
      'users',
      {'email': email, 'password': password, 'role': 'role'},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final db = await database;
    var result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<void> insertBooking(Map<String, dynamic> bookingData) async {
    final db = await database;
    await db.insert(
      'bookings',
      bookingData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Booking>> getBookings() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('bookings');
    return List.generate(maps.length, (i) {
      return Booking(
        id: maps[i]['id'],
        name: maps[i]['name'],
        email: maps[i]['email'],
        phone: maps[i]['phone'],
        eventDate: maps[i]['eventDate'],
        bookingDate: maps[i]['bookingDate'],
        selectedPackage: maps[i]['selectedPackage'],
        category: maps[i]['category'],
        imagePath: maps[i]['imagePath'],
      );
    });
  }

  Future<List<Map<String, dynamic>>> fetchBookings() async {
    final db = await database;
    return await db.query('bookings');
  }
}
