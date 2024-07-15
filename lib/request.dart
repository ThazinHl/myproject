import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'data.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => RequestScreenState();
}


class RequestScreenState extends State<RequestScreen> {
  List<Budget> selectedBudgetCodes = [];
   List<Request> request = getrequest();
String filter = '';
  bool _sortAscending = true;
  int _sortColumnIndex = 0;

String? _fileName;
  String? _filePath;
final TextEditingController rnoController = TextEditingController(text:'Req-2425-003');
    final TextEditingController rnameController = TextEditingController(text: "Ma Ma");
     //final TextEditingController rcurrency = TextEditingController(text: "Choose");
     final TextEditingController rmountController = TextEditingController();
    final TextEditingController rpurposeController = TextEditingController();
    final TextEditingController rdateController =TextEditingController(text: "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}");
    final TextEditingController rcodeController = TextEditingController();
     final TextEditingController radminController = TextEditingController(text: "Mg Mg");
     String rtype = 'Project';

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
  bool showMultiSelect = false; // Flag to control the visibility of MultiSelectDialogField
  List<Budget> selectedBudgetCodes = []; // List to hold selected budget codes

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Add Advance Request Form'),
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
                          controller: rnoController,
                          decoration: InputDecoration(
                            labelText: 'Request No',
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                        ),
                        SizedBox(height: 30),
                        TextField(
                          controller: rnameController,
                          decoration: InputDecoration(
                            labelText: 'Requester',
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                        ),
                        SizedBox(height: 30),
                        DropdownButtonFormField<String>(
                          value: rtype,
                          items: ['Project', 'Trip', 'Operation']
                              .map((rtype) => DropdownMenuItem(
                                    value: rtype,
                                    child: Text(rtype),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              rtype = value!;
                              if (rtype == 'Project') {
                                showProjectDialog();
                              } else if (rtype == 'Trip') {
                                showTripDialog();
                              } else if (rtype == 'Operation') {
                                showMultiSelect = true;
                              } else {
                                showMultiSelect = false;
                              }
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Request Type',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 30),
                        TextField(
                          controller: rcodeController,
                          decoration: InputDecoration(
                            labelText: 'Project Code',
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                        ),
                        SizedBox(height: 30),
                        TextField(
                          controller: rmountController,
                          decoration: InputDecoration(
                            labelText: 'Request Amount',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 30),
                        TextField(
                          controller: rpurposeController,
                          decoration: InputDecoration(
                            labelText: 'Purpose of Request',
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
                          controller: rdateController,
                          decoration: InputDecoration(
                            labelText: 'Request Date',
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                        ),
                        SizedBox(height: 30),
                        TextField(
                          controller: radminController,
                          decoration: InputDecoration(
                            labelText: 'Admin',
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
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
                        if (showMultiSelect)
                         MultiSelectDialogField<Budget>(
                        items: getbcode()
                            .map((budget) => MultiSelectItem<Budget>(
                                  budget,
                                  budget.code,
                                ))
                            .toList(),
                        title: Text("Budget Codes"),
                        selectedColor: Colors.blue,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        buttonIcon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blue,
                        ),
                        buttonText: Text(
                          "Select Bcode",
                          style: TextStyle(
                            color: Colors.blue[800],
                            fontSize: 16,
                          ),
                        ),
                        dialogWidth: 300.0, // Set the desired width here
                        dialogHeight: 400.0, // Set the desired height here
                        onConfirm: (results) {
                          setState(() {
                            selectedBudgetCodes = results;
                          });
                        },
                      ),

                        if (showMultiSelect)
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              selectedBudgetCodes.isNotEmpty
                                  ? 'Selected Budget Codes: ${selectedBudgetCodes.map((code) => code.code).join(', ')}'
                                  : 'No budget codes selected',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                /* if  Container(
          child: SingleChildScrollView(
         child: DataTable(
          border: TableBorder.all(),
                columns: [
                  DataColumn(
                    label: Text('Budget Code'),
                    
                  ),
                  DataColumn(
                    label: Text('Description'),
                   
                  ),
                 
                ],


                rows: .map((budget) {
                  return DataRow(cells: [
                    DataCell(Text(budget.code)),
                    DataCell(Text(budget.description)),    
                  ]);
                }).toList(),
              ),
          )),*/


                 
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

  /*void _showAddDialog() {
  bool showMultiSelect = false; // Flag to control the visibility of MultiSelectDialogField
  List<Budget> selectedBudgetCodes = []; // List to hold selected budget codes
 showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Add Advance Request Form'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 80),
                      Container(width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: rnoController,
                              decoration: InputDecoration(
                                labelText: 'Request No',
                                border: OutlineInputBorder(),
                              ),
                              enabled: false,
                            ),
                            SizedBox(height: 30),
                            TextField(
                              controller: rnameController,
                              decoration: InputDecoration(
                                labelText: 'Requester',
                                border: OutlineInputBorder(),
                              ),
                              enabled: false,
                            ),
                            SizedBox(height: 30),
                            DropdownButtonFormField<String>(
                              value: rtype,
                              items: ['Project', 'Trip', 'Operation']
                                  .map((rtype) => DropdownMenuItem(
                                        value: rtype,
                                        child: Text(rtype),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  rtype = value!;
                                  if (rtype == 'Project') {
                                    showProjectDialog();
                                  } else if (rtype == 'Trip') {
                                    showTripDialog();
                                  } else if (rtype == 'Operation') {
                                    showMultiSelect = true;
                                  } else {
                                    showMultiSelect = false;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Request Type',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 30),
                            TextField(
                              controller: rcodeController,
                              decoration: InputDecoration(
                                labelText: 'Project Code',
                                border: OutlineInputBorder(),
                              ),
                              enabled: false,
                            ),
                            SizedBox(height: 30),
                            TextField(
                              controller: rmountController,
                              decoration: InputDecoration(
                                labelText: 'Request Amount',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 30),
                            TextField(
                              controller: rpurposeController,
                              decoration: InputDecoration(
                                labelText: 'Purpose of Request',
                                border: OutlineInputBorder(
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 80),
                      Container(width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: rdateController,
                              decoration: InputDecoration(
                                labelText: 'Request Date',
                                border: OutlineInputBorder(),
                              ),
                              enabled: false,
                            ),
                            SizedBox(height: 30),
                            TextField(
                              controller: radminController,
                              decoration: InputDecoration(
                                labelText: 'Admin',
                                border: OutlineInputBorder(),
                              ),
                              enabled: false,
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
                            Text(_filePath != null ? 'File path: $_filePath' : ''),
                            if (showMultiSelect)
                              MultiSelectDialogField<Budget>(
                                items: getbcode()
                                    .map((budget) => MultiSelectItem<Budget>(
                                          budget,
                                          budget.code,
                                        ))
                                    .toList(),
                                title: Text("Budget Codes"),
                                selectedColor: Colors.blue,
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                ),
                                buttonIcon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.blue,
                                ),
                                buttonText: Text(
                                  "Select Budget Codes",
                                  style: TextStyle(
                                    color: Colors.blue[800],
                                    fontSize: 16,
                                  ),
                                ),
                                onConfirm: (results) {
                                  setState(() {
                                    selectedBudgetCodes = results;
                                  });
                                },
                              ),
                            if (showMultiSelect)
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text(
                                  selectedBudgetCodes.isNotEmpty
                                      ? 'Selected Budget Codes: ${selectedBudgetCodes.map((code) => code.code).join(', ')}'
                                      : 'No budget codes selected',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(width: 80),
                    ],
                  ),
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
                child: Text('Add'),
              ),
            ],
          );
        },
      );
    },
  );
}*/

  /*
  void _showAddDialog() {
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
   
        return AlertDialog(
      
          title: Text('Add Advance Request Form'),
          content: SingleChildScrollView(
            
            child: Column(
              
              children: [
                Row(
                  children: [
                    SizedBox(width:80),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         TextField(
                controller: rnoController,
                decoration: InputDecoration(labelText: 'Request No',border: OutlineInputBorder(),),
                enabled: false,
              ),
               SizedBox(height: 30),

              TextField(
                controller: rnameController,
                decoration: InputDecoration(labelText: 'Requester',border: OutlineInputBorder(),),
                enabled: false,
              ),
               SizedBox(height: 30),


                         DropdownButtonFormField<String>(
                value:rtype,
                items: ['Project', 'Trip','Operation']
                    .map((rtype) => DropdownMenuItem(
                          value: rtype,
                          child: Text(rtype),
                        ))
                    .toList(),
                onChanged: (value) {
                setState(() {
                  rtype= value!;
                  if(rtype=='Project'){
                    showProjectDialog();
                  }else if(rtype=='Trip'){
                    showTripDialog();
                  }
                });
              },
                decoration: InputDecoration(labelText: 'Request Type',border: OutlineInputBorder(),),
              ),
               SizedBox(height: 30),

               TextField(
                controller: rcodeController,
                decoration: InputDecoration(labelText: 'Project Code',border: OutlineInputBorder(),),
                enabled: false,
              ),
              SizedBox(height: 30),
              
               // Container(child:Row( children:[
               /* Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [*/
                        

              TextField(
                controller: rmountController,
                decoration: InputDecoration(labelText: 'Request Amount',border: OutlineInputBorder(),),
      
              ),
             
            // ])),
                 SizedBox(height: 30),

              TextField(
                controller: rpurposeController,
                decoration: InputDecoration(labelText: 'Purpose of Request',border: OutlineInputBorder(),),
                
              ),
             

                        ],
                      ),
                    ),
                    SizedBox(width:80),
                    Expanded(
                      child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         
                       
                         TextField(
              controller: rdateController,
              decoration: InputDecoration(  labelText: 'Reqest Date',
                border: OutlineInputBorder(),
                  ), 
                  enabled: false,  ),

                    SizedBox(height: 30),

                           TextField(
                controller: radminController,
                decoration: InputDecoration(labelText: 'Admin',border: OutlineInputBorder(),),
                enabled: false,
              ),
               SizedBox(height: 30),

               ElevatedButton(
              onPressed: pickFile,
              child: Text('Pick a File'),
            ),
            SizedBox(height: 10),
            Text(_fileName != null ? 'File name: $_fileName' : 'No file selected'),
            Text(_filePath != null ? 'File path: $_filePath' : ''),


 MultiSelectDialogField<Budget>(
                          items: getbcode()
                              .map((budget) => MultiSelectItem<Budget>(
                                    budget,
                                    budget.code,
                                  ))
                              .toList(),
                          title: Text("Budget Codes"),
                          selectedColor: Colors.blue,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          buttonIcon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.blue,
                          ),
                          buttonText: Text(
                            "Select Budget Codes",
                            style: TextStyle(
                              color: Colors.blue[800],
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (results) {
                            setState(() {
                              selectedBudgetCodes = results;
                            });
                          },
                        ),
                          

                      ],
                    ),
                  ),
                    SizedBox(width:80),
                  ],
                ),
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
               /* setState(() {
                  _budgetCodes.add({
                    'code': codeController.text,
                    'description': descriptionController.text,
                    'status': status,
                  });
                });*/
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
          );
      },
    );
  }*/


 void showProjectDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Project Table'),
        content: SingleChildScrollView(
          child: ProjectTable(
            projects: getproject(),
            onRowSelected: (String selectedProjectCode) {
              setState(() {
                rcodeController.text = selectedProjectCode;
              });
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
  void showTripDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Trip table'),
         content: SingleChildScrollView(
          child: TripTable(trips: gettrip(),
           onRowSelected: (String selectedTripCode) {
              setState(() {
                rcodeController.text = selectedTripCode;
              });
            },),
        ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

 
  //filter
 List<Request> get filteredRequest {
   
  if(filter.isEmpty){
    return request;
  }else{
    return request.where((code){
       return code.rno.contains(filter) ||
            code.rcode.contains(filter) ||
            code.rmount.contains(filter) ||
             code.rcurrency.contains(filter) ||
            code.rpurpose.contains(filter) ||
            code.rdate.contains(filter) ||
            code.rstatus.contains(filter) ||
            code.rfile.contains(filter);
    }).toList();
  }
}

//sort
void _sort<T>(Comparable<T> Function(Request) getField, int columnIndex, bool ascending) {
    filteredRequest.sort((a, b) {
      if (!ascending) {
        final Request c = a;
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
        Container(child: Text('Advance Request',style:TextStyle(fontSize:25))),
      
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
         
       Container(
        width: 1500,
          child: SingleChildScrollView(
            child: DataTable(
               border: TableBorder.all(),
             sortColumnIndex: _sortColumnIndex,
                sortAscending: _sortAscending,
              columns: [
                DataColumn(
                  label: Text('Request No'),
                   onSort: (int columnIndex, bool ascending) =>
                        _sort<String>((Request request) => request.rno, columnIndex, ascending),
                  ),
                DataColumn(
                  label: Text('Requested Code'),
                  onSort: (int columnIndex, bool ascending) =>
                        _sort<String>((Request request) => request.rcode, columnIndex, ascending),
             
                ),
                DataColumn(
                  label: Text('Request Amount'),
                  onSort: (int columnIndex, bool ascending) =>
                        _sort<String>((Request request) => request.rmount, columnIndex, ascending),
                ),
                
                DataColumn(
                  label: Text('Purpose of Request'),
                  onSort: (int columnIndex, bool ascending) =>
                        _sort<String>((Request request) => request.rpurpose, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('Request Date'),
                  onSort: (int columnIndex, bool ascending) =>
                        _sort<String>((Request request) => request.rdate, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('Status'),
                  onSort: (int columnIndex, bool ascending) =>
                        _sort<String>((Request request) => request.rstatus, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('Attachments'),
                  onSort: (int columnIndex, bool ascending) =>
                        _sort<String>((Request request) => request.rfile, columnIndex, ascending),
                ),
              ],
              rows: filteredRequest.map((request) {
                return DataRow(cells: [
                  DataCell(Text(request.rno)),
                  DataCell(Text(request.rcode)),
                  DataCell(Text(request.rmount+request.rcurrency)),
                  DataCell(Text(request.rpurpose)),
                  DataCell(Text(request.rdate)),
                  DataCell(Text(request.rstatus)),
                  DataCell(Text(request.rfile)),
                ]);
              }).toList(),
            ),
          ),
        ),
       
      ],
    );
  }
}
 


// Project Table Widget
class ProjectTable extends StatelessWidget {
  final List<Project> projects;
  final void Function(String) onRowSelected;

  const ProjectTable({required this.projects, required this.onRowSelected, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Project Code')),
        DataColumn(label: Text('Project Description')),
        DataColumn(label: Text('Budget Code')),
        DataColumn(label: Text('Total Budget Amount')),
        DataColumn(label: Text('Approved Amount')),
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('Requestable')),
      ],
      rows: projects.map((project) {
        return DataRow(
          cells: [
            DataCell(Text(project.pcode)),
            DataCell(Text(project.pdes)),
            DataCell(Text(project.bcode)),
            DataCell(Text(project.tbmount+project.pcurrency)),
            DataCell(Text(project.apmount)),
            DataCell(Text(project.pstatus)),
            DataCell(Text(project.preq)),
          ],
          onSelectChanged: (bool? selected) {
            if (selected ?? false) {
              onRowSelected(project.pcode);
              Navigator.of(context).pop();
            }
          },
        );
      }).toList(),
    );
  }
}

 
   // Trip Table Widget
class TripTable extends StatelessWidget {
  final List<Trip> trips;
  final void Function(String)onRowSelected;
  const TripTable({required this.trips,required this.onRowSelected, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Trip Code')),
        DataColumn(label: Text('Trip Description')),
        DataColumn(label: Text('Budget Code')),
        DataColumn(label: Text('Trip Amount')),
        DataColumn(label: Text('Approved Amount')),
        DataColumn(label: Text('Status')),
      ],
      rows: trips.map((trip) {
        return DataRow(cells: [
          DataCell(Text(trip.tcode)),
          DataCell(Text(trip.tdes)),
          DataCell(Text(trip.bcode)),
          DataCell(Text(trip.tbmount+trip.tcurrency)),
          DataCell(Text(trip.apmount)),
          DataCell(Text(trip.tstatus)),
        ],
         onSelectChanged: (bool? selected) {
            if (selected ?? false) {
              onRowSelected(trip.tcode);
              Navigator.of(context).pop();
            }
          },
        );
      }).toList(),
    );
  }
} 




