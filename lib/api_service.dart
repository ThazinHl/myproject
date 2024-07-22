import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
   //final  String baseUrl = 'http://192.168.100.25:3000';
  static const String baseUrl = 'http://localhost:3000'; // Replace with your JSON Server URL
  static const  String budgetCodesEndpoint = '/budgets'; // Make sure this matches your db.json endpoint

  Future<List<Budget>> fetchBudgetCodes() async {
    final response = await http.get(Uri.parse(baseUrl + budgetCodesEndpoint));

    if (response.statusCode == 200) {
      List<dynamic> budgets = json.decode(response.body);
      List<Budget> budgetCodes = budgets.map((json) => Budget.fromJson(json)).toList();
      return budgetCodes;
    } else {
      throw Exception('Failed to load budget codes');
    }
  }
  

  Future<void> addBudgetCode(Budget budget) async {
    final response = await http.post(
      Uri.parse(baseUrl + budgetCodesEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(budget.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add budget code');
    }
  }

  Future<void> updateBudgetCode(Budget budget) async {
    final response = await http.put(
      Uri.parse('$baseUrl$budgetCodesEndpoint/${budget.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(budget.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update budget code');
    }
  }

  Future<void> deleteBudgetCode(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$budgetCodesEndpoint/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete budget code');
    }
  }
}

class Budget {
  final String id;
  final String code;
  final String description;
  final bool status;

  Budget({
    required this.id,
    required this.code,
    required this.description,
    required this.status,
  });

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      id: json['id'],
      code: json['code'],
      description: json['description'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'description': description,
      'status': status,
    };
  }
}
