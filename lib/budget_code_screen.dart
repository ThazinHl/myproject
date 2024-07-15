


import 'package:flutter/material.dart';
import 'data.dart';
class BudgetCodeScreen extends StatefulWidget {
  const BudgetCodeScreen({super.key});

  @override
  State<BudgetCodeScreen> createState() => _BudgetCodeScreenState();
}

class _BudgetCodeScreenState extends State<BudgetCodeScreen> {
   List<Budget> _budgetCodes = getbcode();
  String filter = '';
  bool _sortAscending = true;
  int _sortColumnIndex = 0;

  void _showAddDialog() {
    final TextEditingController codeController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    String status = 'Active';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Budget Code'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: codeController,
                decoration: InputDecoration(labelText: 'Budget Code', border: OutlineInputBorder(),),
              ),SizedBox(height: 30),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description', border: OutlineInputBorder(),),
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
              onPressed: () {
                setState(() {
                  _budgetCodes.add(
                    Budget(
                      codeController.text,
                      descriptionController.text,
                      status,
                    ),
                  );
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

 void showEditDialog(Budget budget) {
   final TextEditingController codeController = TextEditingController(text: budget.code);
    final TextEditingController descriptionController = TextEditingController(text: budget.description);
    String status = budget.status;


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
                decoration: InputDecoration(labelText: 'Budget Code', border: OutlineInputBorder(),),
              ),
              SizedBox(height: 30),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description', border: OutlineInputBorder(),),
              ),
              SizedBox(height: 30),
               DropdownButtonFormField<String>(
                value: status,
                items: ['Active', 'Inactive']
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    status = value;
                  }
                },
                decoration: InputDecoration(labelText: 'Status'),
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
              onPressed: () {
                setState(() {
                /*  budget.code= codeController.text;
                  budget.description= descriptionController.text;
                  budget.status = status;*/
                  
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

 void deleteBudgetCode(Budget budget) {
    setState(() {
      _budgetCodes.remove(budget);
    });
  }


  //detail
void Budgetdetail(Budget budget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Bdetail(budgetCode: budget),
      ),
    );
  }

  //filter
 List<Budget> get _filteredBudgetCodes {
    if (filter.isEmpty) {
      return _budgetCodes;
    } else {
      return _budgetCodes.where((code) {
        return code.code.contains(filter) ||
            code.description.contains(filter) ||
            code.status.contains(filter);
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
        Container(child: Text('Budget Codes',style:TextStyle(fontSize:25))),
      
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
                  onPressed: () {
                    setState(() {
                      _budgetCodes = getbcode();
                    });
                  },
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
        width: 1500,
          child: SingleChildScrollView(
         child: DataTable(
          border: TableBorder.all(),
                sortColumnIndex: _sortColumnIndex,
                sortAscending: _sortAscending,
                columns: [
                  DataColumn(
                    label: Text('Budget Code'),
                    onSort: (int columnIndex, bool ascending) =>
                        _sort<String>((Budget budget) => budget.code, columnIndex, ascending),
                  ),
                  DataColumn(
                    label: Text('Description'),
                    onSort: (int columnIndex, bool ascending) =>
                        _sort<String>((Budget budget) => budget.description, columnIndex, ascending),
                  ),
                  DataColumn(
                    label: Text('Status'),
                    onSort: (int columnIndex, bool ascending) =>
                        _sort<String>((Budget budget) => budget.status, columnIndex, ascending),
                  ),
                  DataColumn(label: Text('Actions')),
                ],


                rows: _filteredBudgetCodes.map((budget) {
                  return DataRow(cells: [
                    DataCell(Text(budget.code)),
                    DataCell(Text(budget.description)),
                    DataCell(Text(budget.status)),
                    DataCell(Row(
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
                    )),
                  ]);
                }).toList(),
              ),
          ))
       
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
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Budget Code: ${budgetCode.code}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Description: ${budgetCode.description}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Status: ${budgetCode.status}', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}



