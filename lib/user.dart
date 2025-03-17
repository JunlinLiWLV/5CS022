import 'package:mysql1/mysql1.dart';

class User {
  final int? id;
  final String name;
  final String email;
  final String phone;
  final bool contact;

  User({this.id, required this.name, required this.email, required this.phone, required this.contact});
  
  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, phone: $phone, contact: $contact}';
  }
}

class UserDao {
  final ConnectionSettings settings;

  UserDao(this.settings);

  // Add a user to the database
  Future<void> addUser(User user) async {
    final conn = await MySqlConnection.connect(settings);
    await conn.query('INSERT INTO Guests (id, name, email, phone, contact) VALUES (?, ?, ?, ?, ?)', [user.id, user.name, user.email, user.phone, user.contact]);
    await conn.close();
  }

  // Get all users from the database
  Future<List<User>> getAllUsers() async {
    final conn = await MySqlConnection.connect(settings);
    final results = await conn.query('SELECT id, name, email, phone, contact FROM Guests');
    await conn.close();

    return results.map((row) => User(
      id: row['id'],
      name: row['name'],
      email: row['email'],
      phone: row['phone'],
      contact: row['contact']
    )).toList();
  }

  // Get a user by ID
  Future<User?> getUserById(int id) async {
    final conn = await MySqlConnection.connect(settings);
    final results = await conn.query('SELECT id, name, email, phone, contact FROM Guests WHERE id = ?', [id]);
    await conn.close();

    if (results.isNotEmpty) {
      final row = results.first;
      return User(
        id: row['id'],
        name: row['name'],
        email: row['email'],
        phone: row['phone'],
        contact: row['contact']
      );
    }
    return null;
  }

  // Remove a user by ID
  Future<void> removeUserById(int id) async {
    final conn = await MySqlConnection.connect(settings);
    await conn.query('DELETE FROM Guests WHERE id = ?', [id]);
    await conn.close();
  }
}

void main() async {
  // Connection settings for MySQL
  final settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: '2350900',
    password: 'Lavinder2010',
    db: 'Guests',
  );

  final userDao = UserDao(settings);

  // Example usage
  await userDao.addUser(User(id: 1, name: 'Alice', email: 'alice@gmail.com', phone: '07531658808', contact: false));
  await userDao.addUser(User(id: 2, name: 'Bob', email: 'bob@gmail.com', phone: '07624228914', contact: true));

  final users = await userDao.getAllUsers();
  print('All Users: $users');

  final user = await userDao.getUserById(1);
  print('User with ID 1: $user');

  await userDao.removeUserById(1);
  final updatedUsers = await userDao.getAllUsers();
  print('All Users after removal: $updatedUsers');
}