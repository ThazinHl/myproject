
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'data.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => PaymentScreenState();
}


class PaymentScreenState extends State<PaymentScreen> {
 final TextStyle columnHeaderStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Color.fromARGB(255, 0, 0, 0),
      
    );
     bool paymentposttable=true;
      bool paymentdrafttable=false;
   List<Payment> payment = getpayment();
    // List<Payment> filteredPayments=getpayment();
String filter = '';
  bool _sortAscending = true;
  int _sortColumnIndex = 0;

String? _fileName;
  String? _filePath;
final TextEditingController pnoController = TextEditingController();
    final TextEditingController wmountController = TextEditingController();
     final TextEditingController pmountController = TextEditingController();
     final TextEditingController pnoteController = TextEditingController();
    final TextEditingController pstatusController = TextEditingController();
    final TextEditingController rpersonController = TextEditingController();
    final TextEditingController paidpersonController = TextEditingController();
    final TextEditingController pdateController =TextEditingController(text: "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}");
    
     String pmethod='Bank';

     

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        _fileName = file.name;
        _filePath = file.path;
      });
    }
  }
  
  void _showAddDialog() {
 

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Add Payment Form'),
            content: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 80),
                  Container(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                                        GestureDetector(
                          onTap: showRequestDialog,
                          child: AbsorbPointer(
                            child: TextField(
                              controller: pnoController,
                             //  rcodeController.text = ' pnoController${operationCounter.toString().padLeft(4, '0')}';
                              //  operationCounter++; // Increment the counter
                              decoration: InputDecoration(
                                labelText: 'Payment No',
                                border: OutlineInputBorder(),
                              ),
                              readOnly: true,
                            ),
                          ),
                        ),
      

                        SizedBox(height: 30),
                        TextField(
                          controller: wmountController,
                          decoration: InputDecoration(
                            labelText: 'Withdrawable Amount',
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                        ),
                        SizedBox(height: 30),
                        TextField(
                          controller: pmountController,
                          decoration: InputDecoration(
                            labelText: 'Payment Amount',
                            border: OutlineInputBorder(),
                          ),
                        
                        ),
                        SizedBox(height: 30),
                        TextField(
                          controller: pnoteController,
                          decoration: InputDecoration(
                            labelText: 'Payment Note',
                            border: OutlineInputBorder(),
                          ), 
                        ),
                       
                      ],
                    ),
                  ),
                  SizedBox(width: 80),
                  Container(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: pdateController,
                          decoration: InputDecoration(
                            labelText: 'Payment Date',
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                        ),
                        SizedBox(height: 30),
                        DropdownButtonFormField<String>(
                value: pmethod,
                items: ['Bank', 'Cash','Cheque']
                    .map((pmethod) => DropdownMenuItem(
                          value: pmethod,
                          child: Text(pmethod),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                   pmethod = value;
                  }
                },        
              ),
                SizedBox(height: 30),
                        TextField(
                          controller: rpersonController,
                          decoration: InputDecoration(
                            labelText: 'Received Person',
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                        ),
                        SizedBox(height: 30),
                        TextField(
                          controller: paidpersonController,
                          decoration: InputDecoration(
                            labelText: 'Paid Person',
                            border: OutlineInputBorder(),
                          ),
                          
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: pickFile,
                          child: Text('Pick a File'),
                        ),
                        SizedBox(height: 10),
                        Text(_fileName != null
                            ? 'File name: $_fileName'
                            : 'No file selected'),
                        Text(_filePath != null
                            ? 'File path: $_filePath'
                            : ''),
                      

                      
                      ],
                    ),
                  ),

       

                 
                  SizedBox(width: 80),
                ],
              ),
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
                  Navigator.of(context).pop();
                },
                child: Text('Submit'),
              ),
            ],
          );
        },
      );
    },
  );
}

 


  //filter
 List<Payment> get filteredPayment {
   
  if(filter.isEmpty){
    return payment;
  }else{
    return payment.where((code){
       return code.pno.contains(filter) ||
            code.pdate.contains(filter) ||
            code.pmethod.contains(filter) ||
             code.pmount.contains(filter) ||
            code.pstatus.contains(filter) ;
            
    }).toList();
  }
}
void showRequestDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Request Table'),
            content: SingleChildScrollView(
              child: RequestTable(
                requests: getrequest(),
                onRowSelected: (String selectedRequestCode) {
                  // Find the selected request object
                  Request? selectedRequest = getrequest().firstWhere((request) => request.rno == selectedRequestCode, orElse: () => Request(0, '', '', 0, 0, '', '', 0, '', 0, 0, 0, '', '', ''));
                  
                  // Generate pno based on selected rno
                  String incrementedPno = '';
                  if (selectedRequest != null) {
                    // Extract the numeric part from rno
                    String numericPart = selectedRequest.rno.split('-')[2]; // Assuming rno format is "Req-2425-001"
                    int incrementedValue = 1;
                    
                    // Check if pno already exists, then increment the numeric part
                    while (getpayment().any((payment) => payment.pno == '${selectedRequest.rno}-$incrementedValue')) {
                      incrementedValue++;
                    }
                    
                    incrementedPno = '${selectedRequest.rno}-$incrementedValue';
                  }
                  
                  // Update controllers with selected request data
                  setState(() {
                    pnoController.text = incrementedPno;
                    wmountController.text = selectedRequest.withdrawnmount.toString();
                    // Update other controllers as needed
                  });
                },
              ),
            ),
            actions: [
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
  );
}
void _editPayment(Payment payment) async {
  // Create a TextEditingController for each field you want to edit
  TextEditingController pnoController = TextEditingController(text: payment.pno);
  TextEditingController pdateController = TextEditingController(text: payment.pdate);
  TextEditingController pmethodController = TextEditingController(text: payment.pmethod);
  TextEditingController pmountController = TextEditingController(text: payment.pmount);

  // Show a dialog to edit payment details
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Payment'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: pnoController,
                decoration: InputDecoration(labelText: 'Payment No'),
              ),
              TextField(
                controller: pdateController,
                decoration: InputDecoration(labelText: 'Payment Date'),
              ),
              TextField(
                controller: pmethodController,
                decoration: InputDecoration(labelText: 'Payment Method'),
              ),
              TextField(
                controller: pmountController,
                decoration: InputDecoration(labelText: 'Payment Amount'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Save'),
            onPressed: () {
              // Update the payment object with new values
              setState(() {
               /* payment.pno = pnoController.text;
                payment.pdate = pdateController.text;
                payment.pmethod = pmethodController.text;
                payment.pmount = pmountController.text;*/
              });

              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog without saving
            },
          ),
        ],
      );
    },
  );
}

void _deletePayment(Payment payment) async {
  // Show a confirmation dialog
  bool confirmDelete = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this payment?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(false); // Return false to indicate cancellation
            },
          ),
          TextButton(
            child: Text('Delete'),
            onPressed: () {
              Navigator.of(context).pop(true); // Return true to indicate deletion
            },
          ),
        ],
      );
    },
  );

  // Delete the payment if confirmation is true
  if (confirmDelete == true) {
    setState(() {
      // Assuming `payment` is part of your `payment` list, remove it
    //  payment.remove(payment);
    });
  }
}



//sort
void _sort<T>(Comparable<T> Function(Payment) getField, int columnIndex, bool ascending) {
    filteredPayment.sort((a, b) {
      if (!ascending) {
        final Payment c = a;
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
  void initState() {
    super.initState();
    _filterPayments();
  }

  void _filterPayments() {
    setState(() {
      if (paymentposttable) {
        payment = getpayment().where((payment) => payment.pstatus == 'Posted').toList();
      } else if (paymentdrafttable) {
        payment = getpayment().where((payment) => payment.pstatus == 'Draft').toList();
      }
    });
  }

    
  @override
  Widget build(BuildContext context) {
   return Column(
      children: [
        Container(child: Text('Payment',style:TextStyle(fontSize:25))),
      
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
        onPressed: () {   },
      ),
    ),
    onChanged: (value) {
      setState(() {
        filter = value;
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
            onPressed:_showAddDialog,
          ),
           
            IconButton(
            icon: Icon(Icons.drafts),
            onPressed: () {
              setState(() {
                paymentdrafttable = !paymentdrafttable;
                 paymentposttable =!paymentposttable;
                  _filterPayments();
              });
            },
          ),
          IconButton(
            icon: Row(
              children: [
                Icon(Icons.refresh),
              ],
            ),
            onPressed: _filterPayments,
            
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
         if (paymentposttable)
          _buildDataTable(),
        if (paymentdrafttable)
          _builddraftDataTable(),
       
      ],
    );
  }
   Widget _buildDataTable() {
    return Container(
      width: 1500,
      child: SingleChildScrollView(
        child: DataTable(
          border: TableBorder.all(),
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          columns: [
            DataColumn(
              label: Text('Payment No', style: columnHeaderStyle),
              onSort: (int columnIndex, bool ascending) =>
                  _sort<String>((Payment payment) => payment.pno, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('Payment Date', style: columnHeaderStyle),
              onSort: (int columnIndex, bool ascending) =>
                  _sort<String>((Payment payment) => payment.pdate, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('Payment Method', style: columnHeaderStyle),
              onSort: (int columnIndex, bool ascending) =>
                  _sort<String>((Payment payment) => payment.pmethod, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('Payment Amount', style: columnHeaderStyle),
              onSort: (int columnIndex, bool ascending) =>
                  _sort<String>((Payment payment) => payment.pmount, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('Status', style: columnHeaderStyle),
              onSort: (int columnIndex, bool ascending) =>
                  _sort<String>((Payment payment) => payment.pstatus, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('Actions', style: columnHeaderStyle),
            ),
          ],
          rows: filteredPayment.map((payment) {
            return DataRow(cells: [
              DataCell(Text(payment.pno)),
              DataCell(Text(payment.pdate)),
              DataCell(Text(payment.pmethod)),
              DataCell(Text(payment.pmount + payment.pcurrency)),
              DataCell(Text(payment.pstatus)),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.details),
                    onPressed: () => null,
                  ),
                ],
              )),
            ]);
          }).toList(),
        ),
      ),
    );
  }
  Widget _builddraftDataTable() {
    return Container(
      width: 1500,
      child: SingleChildScrollView(
        child: DataTable(
          border: TableBorder.all(),
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          columns: [
            DataColumn(
              label: Text('Payment No', style: columnHeaderStyle),
              onSort: (int columnIndex, bool ascending) =>
                  _sort<String>((Payment payment) => payment.pno, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('Payment Date', style: columnHeaderStyle),
              onSort: (int columnIndex, bool ascending) =>
                  _sort<String>((Payment payment) => payment.pdate, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('Payment Method', style: columnHeaderStyle),
              onSort: (int columnIndex, bool ascending) =>
                  _sort<String>((Payment payment) => payment.pmethod, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('Payment Amount', style: columnHeaderStyle),
              onSort: (int columnIndex, bool ascending) =>
                  _sort<String>((Payment payment) => payment.pmount, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('Status', style: columnHeaderStyle),
              onSort: (int columnIndex, bool ascending) =>
                  _sort<String>((Payment payment) => payment.pstatus, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('Actions', style: columnHeaderStyle),
            ),
          ],
          rows: filteredPayment.map((payment) {
            return DataRow(cells: [
              DataCell(Text(payment.pno)),
              DataCell(Text(payment.pdate)),
              DataCell(Text(payment.pmethod)),
              DataCell(Text(payment.pmount + payment.pcurrency)),
              DataCell(Text(payment.pstatus)),
              DataCell(Row(
                children: [
                   IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editPayment(payment),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deletePayment(payment),
                  ),
                ],
              )),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
 


// advance request Table Widget

class RequestTable extends StatelessWidget {
  final List<Request> requests;
  final void Function(String) onRowSelected;

  const RequestTable({required this.requests, required this.onRowSelected, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Request No')),
        DataColumn(label: Text('Purpose of request')),
        DataColumn(label: Text('Request Amount')),
        DataColumn(label: Text('Withdraw Amount')),
      
      ],
      rows: requests.map((request) {
        return DataRow(
          cells: [
            DataCell(Text(request.rno)),
            DataCell(Text(request.rpurpose)),     
            DataCell(Text(request.rmount.toString())),
            DataCell(Text(request.withdrawnmount.toString())),
          ],
          onSelectChanged: (bool? selected) {
            if (selected ?? false) {
              onRowSelected(request.rno);
              //onRowSelected(request.withdrawnmount);
              Navigator.of(context).pop();
            }
          },
        );
      }).toList(),
    );
  }
}

 





