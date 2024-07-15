import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => PaymentScreenState();
}
//enum SortColumn {code,description,status}
//enum SortOrder {ascending,descending}

class PaymentScreenState extends State<PaymentScreen> {
  final List<Map<String, String>> payment = [
    {'pno':'Req-2425-001-1','pdate': '8/7/2024', 'pmethod': 'Cash','pmount':'300000MMK', 'pstatus': 'Posted'},
    {'pno':'Req-2425-001-2','pdate': '8/7/2024', 'pmethod': 'Cash','pmount':'100000MMK', 'pstatus': 'Draft'},
  ];
 /* 
String filter = '';
SortColumn sortColumn=SortColumn.code;
SortOrder sortOrder=SortOrder.ascending;
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
                decoration: InputDecoration(labelText: 'Budget Code'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
             /* DropdownButtonFormField<String>(
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
              ),*/
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
                  _budgetCodes.add({
                    'code': codeController.text,
                    'description': descriptionController.text,
                    'status': status,
                  });
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

 void showEditDialog(Map<String, String> budgetCode) {
    final TextEditingController codeController = TextEditingController(text: budgetCode['code']);
    final TextEditingController descriptionController = TextEditingController(text: budgetCode['description']);
    String status = budgetCode['status']!;

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
                decoration: InputDecoration(labelText: 'Budget Code'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
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
                  budgetCode['code'] = codeController.text;
                  budgetCode['description'] = descriptionController.text;
                  budgetCode['status'] = status;
                  sortBudgetCodes();
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




  //detail
void Bdetail(Map<String, String> budgetCode) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detailbcode(budgetCode: budgetCode),
      ),
    );
  }

  //filter
List<Map<String,String>> get filteredBudgetCodes{
  if(filter.isEmpty){
    return _budgetCodes;
  }else{
    return _budgetCodes.where((code){
      return code['code']!.contains(filter)||
      code['description']!.contains(filter)||
      code['status']!.contains(filter);
    }).toList();
  }
}
//sort
void sortBudgetCodes(){
  setState((){
    _budgetCodes.sort((a,b){
      int compare;
      switch (sortColumn){
        case SortColumn.code:
        compare=a['code']!.compareTo(b['code']!);
        break;
        case SortColumn.description:
            compare = a['description']!.compareTo(b['description']!);
            break;
          case SortColumn.status:
            compare = a['status']!.compareTo(b['status']!);
            break;
      }
      return sortOrder==SortOrder.ascending?compare: -compare;
    });


  });
}

void _toggleSortColumn(SortColumn column) {
    setState(() {
      if (sortColumn == column) {
        sortOrder = sortOrder == SortOrder.ascending ? SortOrder.descending : SortOrder.ascending;
      } else {
        sortColumn = column;
        sortOrder = SortOrder.ascending;
      }
      sortBudgetCodes();
    });
  }

  Widget _buildSortableHeader(String title, SortColumn column) {
    return TableCell(
      child: InkWell(
        onTap: () => _toggleSortColumn(column),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title),
                if (sortColumn == column)
                  Icon(
                    sortOrder == SortOrder.ascending
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    size: 16,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }*/

    
  @override
  Widget build(BuildContext context) {
   return Column(
      children: [
        Container(child: Text('Cash Payment',style:TextStyle(fontSize:25))),
      
      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end, // Aligns widgets to the end
        children: [
          
SizedBox(
  width: 100, // Specifies the width of the TextField
  child: TextField(
    decoration: InputDecoration(
      suffixIcon: IconButton(
        icon: Icon(Icons.filter_list),
        onPressed: () {
          // Define your action for the IconButton here
        //  print('Filter icon pressed');
        },
      ),
     // hintText: 'Filter', // Optionally add a hint text
    ),
    onChanged: (value) {
      setState(() {
        //filter = value;
      });
    },
  ),
),

          IconButton(
            icon: Row(
              children: [
                Icon(Icons.add),
              ],
            ),
            onPressed: null
            //_showAddDialog,
          ),

          IconButton(
            icon: Row(
              children: [
                Icon(Icons.refresh),
              ],
            ),
            onPressed: null,
          ),

          IconButton(
            icon: Row(
              children: [
                Icon(Icons.download),
              ],
            ),
            onPressed: null,
          ),


        ],
      ),
    ),
         
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Table(
            border: TableBorder.all(),
            columnWidths: const {
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
              4: FlexColumnWidth(),
              5: FlexColumnWidth(),
           
          
            },
            children: [
              TableRow(children: [

                  // _buildSortableHeader('Budget Codes', SortColumn.code),
                  // _buildSortableHeader('Description', SortColumn.description),
                  // _buildSortableHeader('Status', SortColumn.status),
                 TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: Text('Payment No')),
                  ),
                ),
                 TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: Text('Payment Date')),
                  ),
                ),
                 TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: Text('Payment Method')),
                  ),
                ),
                 TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: Text('Payment Amount')),
                  ),
                ),
                 TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: Text('Status')),
                  ),
                ),
                
                 
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: Text('Actions')),
                  ),
                ),
              
              ]),
              ...payment.map((code) {
                return TableRow(children: [
                  TableCell(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text(code['pno']!)),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text(code['pdate']!)),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text(code['pmethod']!)),
                    ),
                  ),
                   TableCell(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text(code['pmount']!)),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text(code['pstatus']!)),
                    ),
                  ),
                
             TableCell(
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => null
                                //showEditDialog(code),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    payment.remove(code);
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.details),
                                onPressed: ()=>null
                                //Bdetail(code), 
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),

                ]);
              }).toList(),
            ],
          ),
        ),
       
      ],
    );
  }
}

