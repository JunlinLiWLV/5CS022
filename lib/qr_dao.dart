import 'package:mysql1/mysql1.dart';

class QR {
  final int? id;
  final String code;
  final String name;
  final int? scanned;
  final int? interested;

  QR({this.id, required this.code, required this.name, required this.scanned, required this.interested});
  
  @override
  String toString() {
    return 'QR{id: $id, code: $code, name: $name, scanned: $scanned, interested: $interested}';
  }
}

class QRDao {
  final ConnectionSettings settings;

  QRDao(this.settings);

  // Add a info to the database
  Future<void> add(QR qr) async {
    final conn = await MySqlConnection.connect(settings);
    await conn.query('INSERT INTO QR (id, code, name, scanned, interested) VALUES (?, ?, ?, ?, ?)', [qr.id, qr.code, qr.name, qr.scanned, qr.interested]);
    await conn.close();
  }

  // Get all users from the database
  Future<List<QR>> getAll() async {
    final conn = await MySqlConnection.connect(settings);
    final results = await conn.query('SELECT id, code, name, scanned, interested FROM QR');
    await conn.close();

    return results.map((row) => QR(
      id: row['id'],
      code: row['code'],
      name: row['name'],
      scanned: row['scanned'],
      interested: row['interested']
    )).toList();
  }

}

void main() async {
  // Connection settings for MySQL
  final settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: '2350900',
    password: 'Lavinder2010',
    db: 'QR',
  );

}