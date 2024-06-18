import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'quiz.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE answers(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            questionText TEXT,
            selectedOption TEXT,
            correctOption TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertAnswer(Answer answer) async {
    final db = await database;
    await db.insert('answers', {
      'questionText': answer.question.questionText,
      'selectedOption': answer.selectedOption,
      'correctOption': answer.correctOption
    });
  }

  Future<List<Map<String, dynamic>>> getAnswers() async {
    final db = await database;
    return await db.query('answers');
  }

  Future<void> clearAnswers() async {
    final db = await database;
    await db.delete('answers');
  }
}
