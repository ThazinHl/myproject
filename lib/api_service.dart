/*import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
   //final  String baseUrl = 'http://192.168.100.25:3000';
  static const String baseUrl = 'http://localhost:3000'; // Replace with your JSON Server URL
  static const  String budgetCodesEndpoint = '/budgets'; // Make sure this matches your db.json endpoint

  Future<List<Budget>> fetchBudgets() async {
    final response = await http.get(Uri.parse(baseUrl + budgetCodesEndpoint));

    if (response.statusCode == 200) {
      List<dynamic> budgets = json.decode(response.body);
      List<Budget> budgetCodes = budgets.map((json) => Budget.fromJson(json)).toList();
      return budgetCodes;
    } else {
      throw Exception('Failed to load budget codes');
    }
  }
  

  Future<void> addBudget(Budget budget) async {
    final response = await http.post(
      Uri.parse(baseUrl + budgetCodesEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(budget.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add budget code');
    }
  }

  Future<void> updateBudget(Budget budget) async {
    final response = await http.put(
      Uri.parse('$baseUrl$budgetCodesEndpoint/${budget.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(budget.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update budget code');
    }
  }

  Future<void> deleteBudget(String id) async {
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
}*/
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'http://localhost:3000';
  final String budgetCodesEndpoint = '/budgets'; 
   final String requestEndpoint = '/requests'; 
  final String paymentEndpoint = '/payments'; 
   final String projectEndpoint = '/projects'; 
  final String tripEndpoint = '/trips'; 
  Future<List<Budget>> fetchBudgets() async {
    final response = await http.get(Uri.parse(apiUrl+ budgetCodesEndpoint));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Budget.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load budgets');
    }
  }

  Future<void> addBudget(Budget budget) async {
    final response = await http.post(
      Uri.parse(apiUrl+ budgetCodesEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(budget.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add budget');
    }
  }

  Future<void> updateBudget(Budget budget) async {
    final response = await http.put(
      Uri.parse('$apiUrl$budgetCodesEndpoint/${budget.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(budget.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update budget');
    }
  }
    Future<void> deleteBudget(String id) async {
    final response = await http.delete(Uri.parse('$apiUrl$budgetCodesEndpoint/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete budgetCode');
    }
  }
  
    //for payment
     Future<List<Payment>> fetchPayments() async {
    final response = await http.get(Uri.parse(apiUrl+ paymentEndpoint));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Payment.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load payments');
    }
  }

  Future<void> addPayment(Payment payment) async {
    final response = await http.post(
      Uri.parse(apiUrl+ paymentEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payment.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add payment');
    }
  }

  Future<void> updatePayment(Payment payment) async {
    final response = await http.put(
      Uri.parse('$apiUrl$paymentEndpoint/${payment.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payment.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update payment');
    }
  }

  Future<void> deletePayment(String id) async {
    final response = await http.delete(Uri.parse('$apiUrl$paymentEndpoint/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete payment');
    }
  }

  
    //for request
     Future<List<Request>> fetchRequests() async {
    final response = await http.get(Uri.parse(apiUrl+ requestEndpoint));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Request.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load requests');
    }
  }

  Future<void> addRequest(Request request) async {
    final response = await http.post(
      Uri.parse(apiUrl+ requestEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add payment');
    }
  }

//for project
     Future<List<Project>> fetchProjects() async {
    final response = await http.get(Uri.parse(apiUrl+ projectEndpoint));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Project.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load projects');
    }
  }
 //for trip
     Future<List<Trip>> fetchTrips() async {
    final response = await http.get(Uri.parse(apiUrl+ tripEndpoint));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Trip.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load trips');
    }
  }

}
//for budget
class Budget {
  final String id;
  final String code;
  final String description;
  final bool status;

  Budget({required this.id, required this.code, required this.description, required this.status});

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
//for project
class Project {
  final String id;
  final String pcode;
  final String pdes;
  final List<String> bcode;
  final double tbmount;
  final String pcurrency;
  final double apmount;
  final String pstatus;
  final String preq;

  Project({required this.id,required this.pcode,required this.pdes, required this.bcode,required this.tbmount,required this.pcurrency,required this.apmount,
    required this.pstatus,required this.preq, });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      pcode: json['pcode'],
      pdes: json['pdes'],
      bcode: List<String>.from(json['bcode']),
      tbmount: json['tbmount'].toDouble(),
      pcurrency: json['pcurrency'],
      apmount: json['apmount'].toDouble(),
      pstatus: json['pstatus'],
      preq: json['preq'],
    );
  }
}

//for trip
class Trip {
  final String id;
  final String tcode;
  final String tdes;
  final List<String> bcode;
  final double tbmount;
  final String tcurrency;
  final double apmount;
  final String tstatus;

  Trip({
    required this.id,
    required this.tcode,
    required this.tdes,
    required this.bcode,
    required this.tbmount,
    required this.tcurrency,
    required this.apmount,
    required this.tstatus,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      tcode: json['tcode'],
      tdes: json['tdes'],
      bcode: List<String>.from(json['bcode']),
      tbmount: json['tbmount'].toDouble(),
      tcurrency: json['tcurrency'],
      apmount: json['apmount'].toDouble(),
      tstatus: json['tstatus'],
    );
  }
}

//for Request
class Request {
 final String id;
  final String rno;
  final String rcode;
  final double rmount;
  final double withdrawnmount;
   final String rcurrency;
  final String rpurpose;
  final int requester_id;
  final String rdate;
  final int approver1_id;
  final int approver2_id;
  final int approver3_id;
  final String approver_date;
   final String rstatus;
  final String rfile;
 
 
Request({required this.id,required this.rno,required this.rcode,required this.rmount,required this.withdrawnmount,required this.rcurrency,
 required this.rpurpose,required this.requester_id,required this.rdate,required this.approver1_id,required this.approver2_id,required this.approver3_id,required this.approver_date,required this.rstatus,required this.rfile});
  
  factory  Request.fromJson(Map<String, dynamic> json) {
    return  Request(
      id: json['id'],
      rno: json['rno'],
      rcode: json['rcode'],
      rmount: json['rmount'],
      withdrawnmount: json['withdrawnmount'],
       rcurrency: json['rcurrency'],
       rpurpose: json['rpurpose'],
      requester_id: json['requester_id'],
      rdate: json['rdate'],
      approver1_id: json['approver1_id'],
      approver2_id: json['approver2_id'],
      approver3_id: json['approver3_id'],
      approver_date: json['approver_date'],
      rstatus: json['rstatus'],
       rfile: json['rfile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rno': rno,
      'rcode': rcode,
      'rmount': rmount,
      'withdrawnmount': withdrawnmount,
       'rcurrency': rcurrency,
        'rpurpose': rpurpose,
      'requester_id': requester_id,
      'rdate': rdate,
      'approver1_id': approver1_id,
      'approver2_id': approver2_id,
      'approver3_id': approver3_id,
      'approver-date':approver_date,
      'rstatus':rstatus,
      'pfile': rfile,
    };
  }
}
class Payment {
  final String id;
  final String pno;
  final String pdate;
  final String pmethod;
   final double wdmount;
  final double pmount;
  final String pcurrency;
  final String pstatus;
  final String pnote;
  final String preceive;
  final String ppaid;
  final String pfile;
 

  Payment({required this.id,required this.pno,required  this.pdate,required this.pmethod,required this.wdmount,
  required this.pmount,required this.pcurrency,required this.pstatus,required this.pnote,required this.preceive,required this.ppaid,required this.pfile});

  
  factory  Payment.fromJson(Map<String, dynamic> json) {
    return  Payment(
      id: json['id'],
      pno: json['pno'],
      pdate: json['pdate'],
      pmethod: json['pmethod'],
      wdmount: json['wdmount'],
      pmount: json['pmount'],
      pcurrency: json['pcurrency'],
      pstatus: json['pstatus'],
       pnote: json['pnote'],
      preceive: json['preceive'],
      ppaid: json['ppaid'],
      pfile: json['pfile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pno': pno,
      'pdate': pdate,
      'pmethod': pmethod,
      'wdmount': wdmount,
      'pmount': pmount,
      'pcurrency': pcurrency,
      'pstatus': pstatus,
      'pnote': pnote,
      'preceive': preceive,
      'ppaid': ppaid,
      'pfile': pfile,
    };
  }
}

