
import 'package:flutter/material.dart';
import 'api_service.dart'; // Make sure this is the correct import path for your ApiService
import 'dart:math';
class BudgetCodeScreen extends StatefulWidget {
  const BudgetCodeScreen({super.key});

  @override
  State<BudgetCodeScreen> createState() => _BudgetCodeScreenState();
}

class _BudgetCodeScreenState extends State<BudgetCodeScreen> {
  final TextStyle columnHeaderStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Color.fromARGB(255, 0, 0, 0),
  );

  List<Budget> _budgetCodes = [];
  String filter = '';
  bool _sortAscending = true;
  int _sortColumnIndex = 0;
  int _nextId = 1;

String generateRandomId(int length) {                                   // auto enter in id string  
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  Random rnd = Random();
  return List.generate(length, (_) => chars[rnd.nextInt(chars.length)]).join();
}
  @override
  void initState() {
    super.initState();
    _fetchBudgetCodes();
  }

  void _fetchBudgetCodes() async {
    try {
      List<Budget> budgetCodes = await ApiService().fetchBudgetCodes();
      setState(() {
        _budgetCodes = budgetCodes;
        if (_budgetCodes.isNotEmpty) {
          _nextId = _budgetCodes.map((b) => int.parse(b.code.split('-')[1])).reduce((a, b) => a > b ? a : b) + 1;
        }
      });
    } catch (e) {
      print('Failed to load budget codes: $e');
    }
  }

  void _showAddDialog() {
     TextEditingController codeController= TextEditingController(text: 'B-${_nextId.toString().padLeft(3, '0')}');
    final TextEditingController descriptionController = TextEditingController();
    bool status = true;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Budget Code'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
             // Text('Budget Code: B-${_nextId.toString().padLeft(3, '0')}', style: TextStyle(fontSize: 16)),
              TextField(
              controller: codeController,
              decoration: InputDecoration(
                labelText: 'Budget Code',
                border: OutlineInputBorder(),
              ),readOnly: true,
            ),
              SizedBox(height: 30),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
              ),
              SizedBox(height: 30),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  Budget newBudget = Budget(
                    id: generateRandomId(4), // Generate a random 4-character string
                    code: 'B-${_nextId.toString().padLeft(3, '0')}',
                    description: descriptionController.text,
                    status: status,
                  );
                  await ApiService().addBudgetCode(newBudget);
                  setState(() {
                    _budgetCodes.add(newBudget);
                    _nextId++;
                  });
                  Navigator.of(context).pop();
                } catch (e) {
                  print('Failed to add budget code: $e');
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void showEditDialog(Budget budget) {
    TextEditingController codeController = TextEditingController(text: budget.code);
    final TextEditingController descriptionController = TextEditingController(text: budget.description);
    bool status = budget.status;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Budget Code'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
              controller: codeController,
              decoration: InputDecoration(
                labelText: 'Budget Code',
                border: OutlineInputBorder(),
              ),readOnly: true,
            ),
              SizedBox(height: 30),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Switch(
                    value: status,
                    onChanged: (value) {
                      setState(() {
                        status = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  Budget updatedBudget = Budget(
                    id: budget.id,
                    code: budget.code,
                    description: descriptionController.text,
                    status: status,
                  );
                  await ApiService().updateBudgetCode(updatedBudget);
                  setState(() {
                    int index = _budgetCodes.indexWhere((b) => b.id == budget.id);
                    if (index != -1) {
                      _budgetCodes[index] = updatedBudget;
                    }
                  });
                  Navigator.of(context).pop();
                } catch (e) {
                  print('Failed to update budget code: $e');
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void deleteBudgetCode(Budget budget) async {
    try {
      await ApiService().deleteBudgetCode(budget.id);
      setState(() {
        _budgetCodes.remove(budget);
      });
    } catch (e) {
      print('Failed to delete budget code: $e');
    }
  }

  void Budgetdetail(Budget budget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Bdetail(budgetCode: budget),
      ),
    );
  }

  List<Budget> get _filteredBudgetCodes {
    if (filter.isEmpty) {
      return _budgetCodes;
    } else {
      return _budgetCodes.where((code) {
        return code.code.contains(filter) ||
            code.description.contains(filter) ||
            (code.status ? 'Active' : 'Inactive').contains(filter);
      }).toList();
    }
  }

  void _sort<T>(Comparable<T> Function(Budget) getField, int columnIndex, bool ascending) {
    _filteredBudgetCodes.sort((a, b) {
      if (!ascending) {
        final Budget c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(child: Text('Budget Codes', style: TextStyle(fontSize: 25))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end, // Aligns widgets to the end
            children: [
              SizedBox(
                width: 100, // Specifies the width of the TextField
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.filter_list),
                  ),
                  onChanged: (value) {
                    setState(() {
                      filter = value;
                    });
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: _showAddDialog,
              ),
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: _fetchBudgetCodes,
              ),
              IconButton(
                icon: Icon(Icons.download),
                onPressed: () {
                  // Define your download action here
                },
              ),
            ],
          ),
        ),
        Container(
          child: SingleChildScrollView(
            child: DataTable(
              border: TableBorder.all(),
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              columns: [
                DataColumn(
                  label: Text('Budget Code', style: columnHeaderStyle),
                  onSort: (int columnIndex, bool ascending) =>
                      _sort<String>((Budget budget) => budget.code, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('Description', style: columnHeaderStyle),
                  onSort: (int columnIndex, bool ascending) =>
                      _sort<String>((Budget budget) => budget.description, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('Status', style: columnHeaderStyle),
                ),
                DataColumn(
                  label: Text('Actions', style: columnHeaderStyle),
                ),
              ],
              rows: _filteredBudgetCodes.map((budget) {
                return DataRow(cells: [
                  DataCell(
                    Container(
                      width: 200, // Adjust to the desired width
                      child: Text(budget.code),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 600, // Adjust to the desired width
                      child: Text(budget.description),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 200, // Adjust to the desired width
                      child: Text(budget.status ? 'Active' : 'Inactive'),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 200, // Adjust to the desired width
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => showEditDialog(budget),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => deleteBudgetCode(budget),
                          ),
                          IconButton(
                            icon: Icon(Icons.details),
                            onPressed: () => Budgetdetail(budget),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class Bdetail extends StatelessWidget {
  final Budget budgetCode;

  const Bdetail({super.key, required this.budgetCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Code Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Code: ${budgetCode.code}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('Description: ${budgetCode.description}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Status: ${budgetCode.status ? 'Active' : 'Inactive'}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

