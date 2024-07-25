
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
//import 'data.dart';
import 'api_service.dart'; // Make sure this is the correct import path for your ApiService
import 'dart:math';
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
   //List<Payment> payment = getpayment();
    List<Payment> payment =[];
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

String generateRandomString(int length) {                                   // auto enter in id string  
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  Random rnd = Random();
  return List.generate(length, (_) => chars[rnd.nextInt(chars.length)]).join();
}

     @override
  void initState() {
    super.initState();
    _fetchPayments();
    // _filterPayments();
  }

  void _fetchPayments() async {
    try {
      List<Payment> payments = await ApiService().fetchPayments();
      setState(() {
        payment = payments;
         if (paymentposttable) {
        payment = payment.where((payment) => payment.pstatus == 'Posted').toList();
      } else if (paymentdrafttable) {
        payment = payment.where((payment) => payment.pstatus == 'Draft').toList();
      }
      });
    } catch (e) {
      print('Failed to load budget codes: $e');
    }
  }
  /* void _filterPayments() {
    setState(() {
      if (paymentposttable) {
        payment = payment.where((payment) => payment.pstatus == 'Posted').toList();
      } else if (paymentdrafttable) {
        payment = payment.where((payment) => payment.pstatus == 'Draft').toList();
      }
    });
  }*/

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
                                      /*  GestureDetector(
                          onTap: showRequestDialog,
                          child: AbsorbPointer(
                            child: TextField(
                              controller: pnoController,
                              decoration: InputDecoration(
                                labelText: 'Payment No',
                                border: OutlineInputBorder(),
                              ),
                              readOnly: true,
                            ),
                          ),
                        ),*/
                                            GestureDetector(
                      onTap: () {
                        showRequestDialog(context, pnoController, wmountController);
                      },
                      child: AbsorbPointer(
                        child: TextField(
                          controller: pnoController,
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
                onPressed: () async{
                   // Validation for empty or whitespace-only fields
                  String pno = pnoController.text.trim();
                  String wmountStr = wmountController.text.trim();
                  String pmountStr = pmountController.text.trim();
                  String pnote = pnoteController.text.trim();
                  String pdate = pdateController.text.trim();
                  String rperson = rpersonController.text.trim();
                  String paidperson = paidpersonController.text.trim();
                  
                  if (pno.isEmpty ||
                      wmountStr.isEmpty ||
                      pmountStr.isEmpty ||
                      pnote.isEmpty ||
                      pdate.isEmpty ||
                      rperson.isEmpty ||
                      paidperson.isEmpty) {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('All fields must be filled out.'),
                      ),
                    );
                    return;
                  }
                  double wmount = double.tryParse(wmountController.text) ?? 0.0;
                  double pmount = double.tryParse(pmountController.text) ?? 0.0;

                  if (pmount > wmount) {
                    // Show an error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('withdrawable amount cannot be less than the Payment amount.'),
                      ),
                    );
                  } else {
                    // Proceed with submission
                   // Navigator.of(context).pop();
                    try {
                  Payment newpayment = Payment(
                    
                    id: generateRandomString(4), // Generate a random 4-character string
                    pno: pnoController.text,
                    pdate:pdateController.text,
                    pmethod: pmethod,
                    wdmount: wmount,
                    pmount: pmount,
                    pcurrency: '',
                    pstatus: 'Draft',
                    pnote:  pnoteController.text,
                    preceive: rpersonController.text,
                    ppaid: paidpersonController.text,
                    pfile: _fileName ?? '',
                  );
                  await ApiService().addPayment(newpayment);
                  setState(() {
                    payment.add(newpayment);
                    
                  });
                  Navigator.of(context).pop();
                } catch (e) {
                  print('Failed to add budget code: $e');
                }
                  }
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
             code.pmount.toString().contains(filter) ||
            code.pstatus.contains(filter) ;
            
    }).toList();
  }
}
/*void showRequestDialog() {
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
}*/
void showRequestDialog(BuildContext context, TextEditingController pnoController, TextEditingController wmountController) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Request Table'),
            content: SingleChildScrollView(
              child: RequestTable(
                onRowSelected: (String selectedRequestCode) async {
                  // Fetch requests
                  List<Request> requests = await ApiService().fetchRequests();
                  
                  // Find the selected request object
                  Request? selectedRequest = requests.firstWhere((request) => request.rno == selectedRequestCode, 
                  //orElse: () => null
                  );
                  
                  // Generate pno based on selected rno
                  String incrementedPno = '';
                  if (selectedRequest != null) {
                    // Extract the numeric part from rno
                    String numericPart = selectedRequest.rno.split('-')[2]; // Assuming rno format is "Req-2425-001"
                    int incrementedValue = 1;
                    
                    // Fetch payments
                    List<Payment> payments = await ApiService().fetchPayments();
                    
                    // Check if pno already exists, then increment the numeric part
                    while (payments.any((payment) => payment.pno == '${selectedRequest.rno}-$incrementedValue')) {
                      incrementedValue++;
                    }
                    
                    incrementedPno = '${selectedRequest.rno}-$incrementedValue';
                  }
                  
                  // Update controllers with selected request data
                  setState(() {
                    pnoController.text = incrementedPno;
                    wmountController.text = selectedRequest?.withdrawnmount.toString() ?? '';
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

void _editPayment(Payment payment)  {
  // Create a TextEditingController for each field you want to edit
  TextEditingController pno_edit = TextEditingController(text: payment.pno);
  TextEditingController wdmount_edit = TextEditingController(text: payment.wdmount.toString());
  TextEditingController pdate_edit = TextEditingController(text: "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}");
  TextEditingController pmount_edit = TextEditingController(text: payment.pmount.toString());
  TextEditingController pnote_edit = TextEditingController(text: payment.pnote);
  TextEditingController precive_edit = TextEditingController(text: payment.preceive);
  TextEditingController ppaid_edit = TextEditingController(text: payment.ppaid);
  String pmethod_edit=payment.pmethod;
  // Show a dialog to edit payment details
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Edit Payment Form'),
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
                                       
                             TextField(
                              controller: pno_edit,
                              decoration: InputDecoration(
                                labelText: 'Payment No',
                                border: OutlineInputBorder(),
                              ),
                              readOnly: true,
                            ),
                        
                        SizedBox(height: 30),
                        TextField(
                          controller: wdmount_edit,
                          decoration: InputDecoration(
                            labelText: 'Withdrawable Amount',
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                        ),
                        SizedBox(height: 30),
                        TextField(
                          controller: pmount_edit,
                          decoration: InputDecoration(
                            labelText: 'Payment Amount',
                            border: OutlineInputBorder(),
                          ),
                        
                        ),
                        SizedBox(height: 30),
                        TextField(
                          controller: pnote_edit,
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
                          controller: pdate_edit,
                          decoration: InputDecoration(
                            labelText: 'Payment Date',
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                        ),
                        SizedBox(height: 30),
                        DropdownButtonFormField<String>(
                value: pmethod_edit,
                items: ['Bank', 'Cash','Cheque']
                    .map((pmethod_edit) => DropdownMenuItem(
                          value: pmethod_edit,
                          child: Text(pmethod_edit),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                  pmethod_edit = value;
                  }
                },        
              ),
                SizedBox(height: 30),
                        TextField(
                          controller: precive_edit,
                          decoration: InputDecoration(
                            labelText: 'Received Person',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 30),
                        TextField(
                          controller: ppaid_edit,
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
                onPressed: () async {
                  // Validation for empty or whitespace-only fields
                  String pmountStr = pmount_edit.text.trim();
                  String pnote = pnote_edit.text.trim();
                  String rperson = precive_edit.text.trim();
                  String paidperson = ppaid_edit.text.trim();
                  
                  if (
                      pmountStr.isEmpty ||
                      pnote.isEmpty ||
                      rperson.isEmpty ||
                      paidperson.isEmpty) {
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('All fields must be filled out.'),
                      ),
                    );
                    return;
                  }
                  double wmount = double.tryParse(wdmount_edit.text) ?? 0.0;
                  double pmount = double.tryParse(pmount_edit.text) ?? 0.0;

                  if (pmount > wmount) {
                    // Show an error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('withdrawable amount cannot be less than the Payment amount.'),
                      ),
                    );
                    return;
                  } 
                    // Proceed with submission
                   // Navigator.of(context).pop();
                    
                try {
                  Payment updatedPayment = Payment(
                    id:payment.id, 
                    pno: pno_edit.text,
                    pdate:pdate_edit.text,
                    pmethod: pmethod_edit,
                    wdmount: wmount,
                    pmount: pmount,
                    pcurrency: '',
                    pstatus: 'Posted',
                    pnote:  pnote_edit.text,
                    preceive: rperson,
                    ppaid: paidperson,
                    pfile: _fileName ?? '',
                  );
                 await ApiService().updatePayment(updatedPayment);
                    setState(() {
                      // int index = payment.indexWhere((p) => p.id == updatedPayment.id);
                      // if (index != -1) {
                      //   payment[index] = updatedPayment;
                      // }
                    });
                    Navigator.of(context).pop();
                  } catch (e) {
                    print('Failed to update payment: $e');
                  }
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

void Paymentdetail(Payment payment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Pdetail(payment: payment),
      ),
    );
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
                //  _filterPayments();
                 _fetchPayments();
              });
            },
          ),
          IconButton(
            icon: Row(
              children: [
                Icon(Icons.refresh),
              ],
            ),
            onPressed:  _fetchPayments,
            
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
                  _sort<String>((Payment payment) => payment.pmount.toString(), columnIndex, ascending),
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
              DataCell(Text(payment.pmount.toString() + payment.pcurrency)),
              DataCell(Text(payment.pstatus)),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.more_horiz_outlined),
                     onPressed: () => Paymentdetail(payment),
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
                  _sort<String>((Payment payment) => payment.pmount.toString(), columnIndex, ascending),
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
              DataCell(Text(payment.pmount.toString() + payment.pcurrency)),
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

/*class RequestTable extends StatelessWidget {
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
}*/
class RequestTable extends StatefulWidget {
  final void Function(String) onRowSelected;

  const RequestTable({required this.onRowSelected, Key? key}) : super(key: key);

  @override
  _RequestTableState createState() => _RequestTableState();
}

class _RequestTableState extends State<RequestTable> {
  late Future<List<Request>> _requestsFuture;

  @override
  void initState() {
    super.initState();
    _requestsFuture = ApiService().fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Request>>(
      future: _requestsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No requests found');
        } else {
          List<Request> requests = snapshot.data!;
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
                    widget.onRowSelected(request.rno);
                    Navigator.of(context).pop();
                  }
                },
              );
            }).toList(),
          );
        }
      },
    );
  }
}

 class Pdetail extends StatelessWidget {
 final Payment payment;

  const Pdetail({super.key, required this.payment});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back)),
        title: Text('Back',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),),
      ),
    body:
    Center(
     
      child: Container(
         
            color: Color.fromRGBO(204, 213, 174, 1),
            height: 1000,
            width: 10000,
        child:
        Padding(
       
        padding: const EdgeInsets.all(16.0),
   
 
        child: Center(
          child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Table(
            border: TableBorder.all(width: 1.0, color: Colors.black),
            columnWidths: {
              0: FixedColumnWidth(400),
              1: FixedColumnWidth(400),
 
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
             
              TableRow(
                decoration: BoxDecoration(color: Colors.grey[300]),
                children: [
                  Padding(padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text('Title', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),) ,),
                  ),
 
                   Padding(padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text('Data', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),) ,),
                  ),
                ],
              ),
 
              TableRow(children: [
                Padding(padding: EdgeInsets.all(8.0),
                child: Center(child: Text('Payment No', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
                ),
 
                 Padding(padding: EdgeInsets.all(8.0),
                child:  Center(child: Text(' ${payment.pno}',style: TextStyle( fontSize: 18,fontWeight: FontWeight.bold),),),
                ),
              ],),
 
 
              TableRow(children: [
                Padding(padding: EdgeInsets.all(8.0),
                child: Center(child: Text('Payment Date', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
                ),
 
                 Padding(padding: EdgeInsets.all(8.0),
                child:  Center(child: Text(' ${payment.pdate}',style: TextStyle( fontSize: 18,fontWeight: FontWeight.bold),),),
               
                ),
              ],),
 
              TableRow(children: [
                Padding(padding: EdgeInsets.all(8.0),
                child: Center(child: Text('Payment Method', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
                ),
 
                 Padding(padding: EdgeInsets.all(8.0),
                child:  Center(child: Text(' ${payment.pmethod}',style: TextStyle( fontSize: 18,fontWeight: FontWeight.bold),),),
 
                ),
              ],),
   TableRow(children: [
                Padding(padding: EdgeInsets.all(8.0),
                child: Center(child: Text('Payment Amount', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
                ),
 
                 Padding(padding: EdgeInsets.all(8.0),
                child:  Center(child: Text(' ${payment.pmount.toString()+payment.pcurrency}',style: TextStyle( fontSize: 18,fontWeight: FontWeight.bold),),),
                ),
              ],),
 
 
              TableRow(children: [
                Padding(padding: EdgeInsets.all(8.0),
                child: Center(child: Text('Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
                ),
 
                 Padding(padding: EdgeInsets.all(8.0),
                child: Center(child:  Text(' ${payment.pstatus}',style: TextStyle( fontSize: 18,fontWeight: FontWeight.bold),),),
               
                ),
              ],),
 
              TableRow(children: [
                Padding(padding: EdgeInsets.all(8.0),
                child: Center(child: Text('Payment Note', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
                ),
 
                Padding(padding: EdgeInsets.all(8.0),
                child:  Center(child: Text(' ${payment.pnote}',style: TextStyle( fontSize: 18,fontWeight: FontWeight.bold),),),
                ),
              ],),

               TableRow(children: [
                Padding(padding: EdgeInsets.all(8.0),
                child: Center(child: Text('Received Preson', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
                ),
 
                 Padding(padding: EdgeInsets.all(8.0),
                child:  Center(child: Text(' ${payment.preceive}',style: TextStyle( fontSize: 18,fontWeight: FontWeight.bold),),),
                ),
              ],),
 
 
              TableRow(children: [
                Padding(padding: EdgeInsets.all(8.0),
                child: Center(child: Text('Paid Preson', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
                ),
 
                 Padding(padding: EdgeInsets.all(8.0),
                child:  Center(child: Text(' ${payment.ppaid}',style: TextStyle( fontSize: 18,fontWeight: FontWeight.bold),),),
               
                ),
              ],),
 
              TableRow(children: [
                Padding(padding: EdgeInsets.all(8.0),
                child: Center(child: Text('Attachment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
                ),
 
                 Padding(padding: EdgeInsets.all(8.0),
                child: Center(child:  Text(' ${payment.pfile}',style: TextStyle( fontSize: 18,fontWeight: FontWeight.bold),),),
 
                ),
              ],),
 
             
            ],
 
           
          ),
          ),
        ),
 
       
       
      ),
      ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:IconButton(onPressed: Navigator.of(context).pop, icon: Icon(Icons.home),iconSize: 70, color: Colors.black,),
    );
   
  }
}





