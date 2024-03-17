import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>> updateUser(int userId, String name, String email) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$userId'),
      body: {'name': name, 'email': email},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final Uri uri = Uri.parse('$baseUrl/register');
    final Map<String, String> body = {
      'name': name,
      'email': email,
      'password': password,
    };

    final http.Response response = await http.post(uri, body: body);

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to Register: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> addKaryawan(String name,String noBp,String noHp, String email, String inputDate) async {
    final Uri uri = Uri.parse('$baseUrl/karyawan');
    final Map<String, String> body = {
      'name': name,
      'email': email,
      'no_bp': noBp,
      'no_hp': noHp,
      'input_date': inputDate,
    };

    final http.Response response = await http.post(uri, body: body);

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to Add Pegawai: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> updateKaryawan(int id, String name, String noBp, String noHp, String email, String inputDate) async {
    final Uri uri = Uri.parse('$baseUrl/karyawan/$id');

    final Map<String, String> body = {
      'name': name,
      'no_bp': noBp,
      'no_hp': noHp,
      'email': email,
      'input_date': inputDate,
    };

    try {
      final http.Response response = await http.put(uri, body: body);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to update karyawan: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to update karyawan: $e');
    }
  }

  Future<Map<String, dynamic>> getUserProfile(int userId) async {
    try {
      final response = await http.get(
          Uri.parse('http://127.0.0.1:8000/api/user/$userId'));
      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        return {
          'name': userData['name'],
          'email': userData['email'],
        };
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      throw Exception('Failed to load user profile: $e');
    }
  }

}
