import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'api_service.dart';
import 'dart:math';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => RequestScreenState();
}


class RequestScreenState extends State<RequestScreen> {
   bool project_bcodetable=false;
    bool trip_bcodetable=false;
  final TextStyle columnHeaderStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Color.fromARGB(255, 0, 0, 0),
      
    );
  List<Budget> selectedBudgetCodes = [];
  List<Budget> selectedProjectBudgets = [];
  List<Budget> selectedTripBudgets = [];
 int _nextId = 1;

String generateRandomId(int length) {                                   // auto enter in id string  
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  Random rnd = Random();
  return List.generate(length, (_) => chars[rnd.nextInt(chars.length)]).join();
}

String filter = '';
  bool _sortAscending = true;
  int _sortColumnIndex = 0;

String? _fileName;
  String? _filePath;
    late final TextEditingController rnoController;
//final TextEditingController rnoController = TextEditingController(text: 'Req-2425-${_nextId.toString().padLeft(3, '0')}');
    final TextEditingController rnameController = TextEditingController(text: "Ma Ma");
     final TextEditingController rmountController = TextEditingController();
    final TextEditingController rpurposeController = TextEditingController();
    final TextEditingController rdateController =TextEditingController(text: "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}");
    final TextEditingController rcodeController = TextEditingController();
     final TextEditingController radminController = TextEditingController(text: "Mg Mg");
     String rtype = 'Project';
     String rcurrency='MMK';

 List<Request> requests = [];
  List<Project> projects = [];
  List<Trip> trips = [];
  List<Budget> budgets = [];
  @override
  void initState() {
    super.initState();
     rnoController = TextEditingController(text: 'Req-2425-${_nextId.toString().padLeft(3, '0')}');
    _fetchRequest();
    
  }

  void _fetchRequest() async {
    try {
      List<Request> requested = await ApiService().fetchRequests();
      List<Budget> budgeted = await ApiService().fetchBudgets();
        List<Project> projected = await ApiService().fetchProjects();
          List<Trip> triped = await ApiService().fetchTrips();
      setState(() {
        
        requests = requested;
         if (requests.isNotEmpty) {
         // _nextId = requests.map((b) => int.parse(b.rno.split('-')[1])).reduce((a, b) => a > b ? a : b) + 1;
           int maxId = requests
              .map((r) => int.tryParse(r.rno.split('-')[2]) ?? 0)
              .reduce((a, b) => a > b ? a : b);
          _nextId = maxId + 1;
        }
          budgets = budgeted;
           projects = projected;
           trips = triped;
           rnoController.text = 'Req-2425-${_nextId.toString().padLeft(3, '0')}'; 
      });
    } catch (e) {
      print('Failed to request: $e');
    }
  }

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
  //bool project_bcodetable=false;
  bool trip_bcodetable=false;
  List<Budget> selectedBudgetCodes = []; // List to hold selected budget codes
  int operationCounter = 1; // Initialize the counter for 'Operation' increment
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
                                 showMultiSelect = false;
                              trip_bcodetable=false;
                                 //  project_bcodetable=true;
                              } else if (rtype == 'Trip') {
                                showTripDialog();
                                 showMultiSelect = false;
                                   project_bcodetable=false;
                                   trip_bcodetable=true;
                              } else if (rtype == 'Operation') {
                                showMultiSelect = true;
                                  project_bcodetable=false;
                                  trip_bcodetable=false;
                              rcodeController.text = 'OPT-2425-${operationCounter.toString().padLeft(4, '0')}';
                                operationCounter++; // Increment the counter
                              }  else {
                                showMultiSelect = false;
                                  project_bcodetable=false;
                                  trip_bcodetable=false;
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
                      //  Container(child:Row(children:[
                           TextField(
                          controller: rmountController,
                          decoration: InputDecoration(
                            labelText: 'Request Amount',
                            border: OutlineInputBorder(),
                          ),
                        ),
                 DropdownButtonFormField<String>(
                value: rcurrency,
                items: ['USD', 'MMK']
                    .map((rcurrency) => DropdownMenuItem(
                          value: rcurrency,
                          child: Text(rcurrency),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    rcurrency = value;
                  }
                },        
              ),
              //])),
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
                        items: budgets
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
           if(project_bcodetable)
           Container(
            width:300,
          child: SingleChildScrollView(
           
              child: DataTable(
                border: TableBorder.all(),
                columns: [
                  DataColumn(
                    label: Text('BudgetCode', style: columnHeaderStyle),  ),
                  DataColumn(
                    label: Text('Description', style: columnHeaderStyle), ),
                 
                ],
                rows: selectedProjectBudgets.map((budget) {
                                  return DataRow(cells: [
                                    DataCell(Text(budget.code)),
                                    DataCell(Text(budget.description)),
                                  ]);
                                }).toList(),
              ),
            
          ),
        ),
         

if (trip_bcodetable)
  Container(
  width: 300,
  child: SingleChildScrollView(
    child: trip_bcodetable ? DataTable(
      border: TableBorder.all(),
      columns: [
        DataColumn(
          label: Text('BudgetCode', style: columnHeaderStyle),
        ),
        DataColumn(
          label: Text('Description', style: columnHeaderStyle),
        ),
      ],
      rows: selectedTripBudgets.map((budget) {
        return DataRow(cells: [
          DataCell(Text(budget.code)),
          DataCell(Text(budget.description)),
        ]);
      }).toList(),
    ) : Container(), // If trip_bcodetable is false, show an empty container
  ),
),



                          
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
                  // Create Request object from form data
                  
                  Request newRequest = Request(
                    id: generateRandomId(4), // Provide ID if needed
                    rno: 'Req-2425-${_nextId.toString().padLeft(3, '0')}',
                    rcode: rcodeController.text,
                    rmount: double.tryParse(rmountController.text) ?? 0.0,
                    withdrawnmount: 0.0, // Set default value or modify as needed
                    rcurrency: rcurrency,
                    rpurpose: rpurposeController.text,
                    requester_id: 0, // Set default value or modify as needed
                    rdate: rdateController.text,
                    approver1_id: 0, // Set default value or modify as needed
                    approver2_id: 0, // Set default value or modify as needed
                    approver3_id: 0, // Set default value or modify as needed
                    approver_date: '', // Set default value or modify as needed
                    rstatus: 'Pending', // Set default value or modify as needed
                    rfile: _filePath ?? '', // Add file path if needed
                  );

                  try {
                    await ApiService().addRequest(newRequest);
                    setState((){
                       _nextId++;
                    });
                    Navigator.of(context).pop(); // Close dialog on success
                    _fetchRequest(); // Refresh the request list
                  } catch (e) {
                    // Handle error
                    print('Failed to add request: $e');
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



void showProjectDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Project Table'),
            content: SingleChildScrollView(
              child: ProjectTable(
                projects: projects,
                onRowSelected: (String selectedProjectCode) { 
                  setState(() {
                     
                    rcodeController.text = selectedProjectCode;
               
                  Project selectedProject = projects.firstWhere((project) => project.pcode == selectedProjectCode);
                    selectedProjectBudgets = budgets.where((budget) => selectedProject.bcode.contains(budget.code)).toList();
                    project_bcodetable = true; // Show the project table
                  });// Delay the pop to ensure the UI updates before closing the dialog
                },
                // selectedProjectBudgets: selectedProjectBudgets, // Pass the updated list
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
    },
  );
}

void showTripDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Trip Table'),
        content: SingleChildScrollView(
          child: TripTable(
            trips: trips,
            onRowSelected: (String selectedTripCode) {
              setState(() {
                rcodeController.text = selectedTripCode;
                Trip selectedTrip =
                    trips.firstWhere((trip) => trip.tcode == selectedTripCode);
                selectedTripBudgets = budgets
                    .where((budget) => selectedTrip.bcode.contains(budget.code))
                    .toList();
                trip_bcodetable = true; 
                // Set to true to show the budget table
              });
             // Navigator.of(context).pop(); // Close the dialog
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

  //filter
 List<Request> get filteredRequest {
   
  if(filter.isEmpty){
    return requests;
  }else{
    return requests.where((code){
       return code.rno.contains(filter) ||
            code.rcode.contains(filter) ||
            code. rmount.toString().contains(filter) ||
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
            onPressed: _fetchRequest,
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
                  label: Text('Request No',style: columnHeaderStyle),
                   onSort: (int columnIndex, bool ascending) =>
                        _sort<String>((Request request) => request.rno, columnIndex, ascending),
                  ),
                DataColumn(
                  label: Text('Requested Code',style: columnHeaderStyle),
                  onSort: (int columnIndex, bool ascending) =>
                        _sort<String>((Request request) => request.rcode, columnIndex, ascending),
             
                ),
                DataColumn(
                  label: Text('Request Amount',style: columnHeaderStyle),
                  onSort: (int columnIndex, bool ascending) =>
                        _sort<String>((Request request) => request.rmount.toString(), columnIndex, ascending),
                ),

                DataColumn(
                  label: Text('Purpose of Request',style: columnHeaderStyle),
                  onSort: (int columnIndex, bool ascending) =>
                        _sort<String>((Request request) => request.rpurpose, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('Request Date',style: columnHeaderStyle),
                  onSort: (int columnIndex, bool ascending) =>
                        _sort<String>((Request request) => request.rdate, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('Status',style: columnHeaderStyle),
                  onSort: (int columnIndex, bool ascending) =>
                        _sort<String>((Request request) => request.rstatus, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text('Attachments',style: columnHeaderStyle),
                  onSort: (int columnIndex, bool ascending) =>
                        _sort<String>((Request request) => request.rfile, columnIndex, ascending),
                ),
              ],
              rows: filteredRequest.map((request) {
                return DataRow(cells: [
                  DataCell(Text(request.rno)),
                  DataCell(Text(request.rcode)),
                  DataCell(Text(request.rmount.toString()+request.rcurrency)),
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

    // Filter projects based on pstatus and preq
    final filteredProjects = projects.where((project) =>
        project.pstatus == 'Active' && project.preq == 'yes').toList();

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
      rows: filteredProjects.map((project) {
        return DataRow(
          cells: [
            DataCell(Text(project.pcode)),
            DataCell(Text(project.pdes)),
            DataCell(Text(project.bcode.join(', '))), // Display budget codes as a comma-separated string
            DataCell(Text(project.tbmount.toString()+project.pcurrency)),
            DataCell(Text(project.apmount.toString())),
            DataCell(Text(project.pstatus)),
            DataCell(Text(project.preq)),
          ],
          onSelectChanged: (bool? selected) {
            if (selected ?? false) {
              onRowSelected(project.pcode);
             //Navigator.of(context).pop();
             Future.delayed(Duration(milliseconds: 100), () {
             Navigator.of(context).pop();
  });
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
     // Filter projects based on pstatus and preq
    final filteredTrips = trips.where((trip) =>trip.tstatus == 'Active').toList();
    return DataTable(
      columns: [
        DataColumn(label: Text('Trip Code')),
        DataColumn(label: Text('Trip Description')),
        DataColumn(label: Text('Budget Code')),
        DataColumn(label: Text('Trip Amount')),
        DataColumn(label: Text('Approved Amount')),
        DataColumn(label: Text('Status')),
      ],
      rows: filteredTrips.map((trip) {
        return DataRow(cells: [
          DataCell(Text(trip.tcode)),
          DataCell(Text(trip.tdes)),
           DataCell(Text(trip.bcode.join(', '))), // Display budget codes as a comma-separated string
          DataCell(Text(trip.tbmount.toString()+trip.tcurrency)),
          DataCell(Text(trip.apmount.toString())),
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
