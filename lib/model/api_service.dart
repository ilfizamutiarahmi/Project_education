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

  // static Future<List<dynamic>> fetchKaryawan() async {
  //   final response = await http.get(Uri.parse('$baseUrl/karyawan'));
  //
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> responseData = json.decode(response.body);
  //     return responseData['result'];
  //   } else {
  //     throw Exception('Failed to load karyawan');
  //   }
  // }

  // static Future<Map<String, dynamic>> addKaryawan(Map<String, dynamic> data) async {
  //   final response = await http.post(
  //     Uri.parse('http://127.0.0.1:8000/api/karyawan'),
  //     body: jsonEncode(data),
  //     headers: {'Content-Type': 'application/json'},
  //   );
  //
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Failed to add karyawan');
  //   }
  // }
  Future<Map<String, dynamic>> addKaryawan(String name, String email, String no_hp, String no_bp) async {
    final Uri uri = Uri.parse('$baseUrl/karyawan');
    final Map<String, String> body = {
      'name': name,
      'email': email,
      'no_hp': no_hp,
      'no_bp': no_bp,
    };

    final http.Response response = await http.post(uri, body: body);

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to Add Pegawai: ${response.body}');
    }
  }

  // static Future<Map<String, dynamic>> updateKaryawan(String id, Map<String, dynamic> data) async {
  //   final response = await http.put(
  //     Uri.parse('http://127.0.0.1:8000/api/karyawan/$id'),
  //     body: jsonEncode(data),
  //     headers: {'Content-Type': 'application/json'},
  //   );
  //
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Failed to update karyawan');
  //   }
  // }

  Future<Map<String, dynamic>> updateKaryawan(int karyawanId, String name, String no_bp, String no_hp,String email) async {
    final response = await http.put(
      Uri.parse('$baseUrl/karyawan/$karyawanId'),
      body: {'name': name, 'no_bp': no_bp, 'no_hp': no_hp, 'email': email},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update user');
    }
  }

  // static Future<void> deleteKaryawan(String id) async {
  //   final response = await http.delete(
  //     Uri.parse('$baseUrl/karyawan/$id'),
  //   );
  //
  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to delete karyawan');
  //   }
  // }

}
