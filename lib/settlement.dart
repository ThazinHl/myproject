
import 'package:flutter/material.dart';
import 'api_service.dart';
 
class Settlement extends StatefulWidget {
  const Settlement({super.key});
 
  @override
  State<Settlement> createState() => _SettlementState();
}
 
class _SettlementState extends State<Settlement> {
  List<SettlementInfo> settlement = [];
  List<Payment> payments = [];
 
  @override
  void initState() {
    super.initState();
    fetchsettle();
  }
 
  void fetchsettle() async {
    try {
      List<SettlementInfo> settle = await ApiService().fetchsettlement();
      List<Payment> payment = await ApiService().fetchPayments();
      setState(() {
        settlement = settle;
        payments = payment;
      });
    } catch (e) {
      print('Fail to load settlement: $e');
    }
  }
 
  void showPaymentDialog(BuildContext context, TextEditingController PaymentNoController, TextEditingController withdrawnController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Payment Table'),
              content: SingleChildScrollView(
                child: PaymentTable(
                  payments: payments,
                  onRowSelected: (String selectedPaymentCode) async {
                    List<Payment> payment = await ApiService().fetchPayments();
 
                    Payment? SelectedPayment = payment.firstWhere((payment) => payment.pno == selectedPaymentCode);
 
                    setState(() {
                      PaymentNoController.text = selectedPaymentCode;
                      withdrawnController.text = SelectedPayment.wdmount.toString();
                    });
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }
 
  void _showFormDialog() {
    final TextEditingController PaymentNoController = TextEditingController();
    final TextEditingController withdrawnController = TextEditingController();
    final TextEditingController settleController = TextEditingController();
    final TextEditingController refundController = TextEditingController();
 
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Settlement'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showPaymentDialog(context, PaymentNoController, withdrawnController);
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      controller: PaymentNoController,
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
                  controller: withdrawnController,
                  decoration: InputDecoration(
                    labelText: 'Withdrawn Amount',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                ),
                SizedBox(height: 30),
                TextField(
                  controller: settleController,
                  decoration: InputDecoration(
                    labelText: 'Settle Amount',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: refundController,
                  decoration: InputDecoration(
                    labelText: 'Refund Amount',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
           
          ),
          actions: [
            TextButton(
              onPressed: () async{
                 SettlementInfo newSettlement = SettlementInfo(
                paymentid: PaymentNoController.text,
                settlementDate: '', // Assuming the current date for settlement
                WithdrawnAmount: int.tryParse(withdrawnController.text) ?? 0,
                settleamount: int.tryParse(settleController.text) ?? 0,
                refundamount: int.tryParse(refundController.text) ?? 0,
                settled: 'Pending', // Example status
              );
 
              // Save the new settlement data to your backend or state management
              setState(() {
                settlement.add(newSettlement);
              });
 
              Navigator.of(context).pop();
 
              },
              child: Text('Add')),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text('Cancel'))
          ],
        );
      },
    );
  }
 
  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this data?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteData(index);
                Navigator.of(context).pop();
              },
              child: Text('Sure'),
            ),
          ],
        );
      },
    );
  }
 
  void _deleteData(int index) {
    setState(() {
      settlement.removeAt(index);
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(204, 213, 174, 1),
        height: 1000,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      _showFormDialog();
                    },
                    icon: Icon(Icons.add),
                    tooltip: 'Add data',
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        fetchsettle();
                      });
                    },
                    icon: Icon(Icons.refresh),
                    tooltip: 'Refresh data',
                  ),
                  IconButton(
                    onPressed: null,
                    icon: Icon(Icons.download),
                    tooltip: 'Download data',
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 75),
                child: SingleChildScrollView(
                  // scrollDirection: Axis.vertical,
                  child: DataTable(
                    border: TableBorder.all(),
                    columns: const <DataColumn>[
                      DataColumn(label: Text('Payment No', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                      DataColumn(label: Text('Settlement Date', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                      DataColumn(label: Text('Withdrawn Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                      DataColumn(label: Text('Settled Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                      DataColumn(label: Text('Refund Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                      DataColumn(label: Text('Settled', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                      DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                    ],
                    rows: settlement.map((settlementInfo) {
                      return DataRow(
                        cells: [
                          DataCell(Text(settlementInfo.paymentid, style: TextStyle(fontWeight: FontWeight.bold))),
                          DataCell(Text(settlementInfo.settlementDate, style: TextStyle(fontWeight: FontWeight.bold))),
                          DataCell(Text(settlementInfo.WithdrawnAmount.toString(), style: TextStyle(fontWeight: FontWeight.bold))),
                          DataCell(Text(settlementInfo.settleamount.toString(), style: TextStyle(fontWeight: FontWeight.bold))),
                          DataCell(Text(settlementInfo.refundamount.toString(), style: TextStyle(fontWeight: FontWeight.bold))),
                          DataCell(Text(settlementInfo.settled, style: TextStyle(fontWeight: FontWeight.bold))),
                          DataCell(Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _showDeleteConfirmationDialog(settlement.indexOf(settlementInfo));
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.more_horiz_outlined),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => _Detail(existingData: settlementInfo),
                                    ),
                                  );
                                },
                              ),
                            ],
                          )),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 
class _Detail extends StatelessWidget {
  final SettlementInfo existingData;
 
  const _Detail({required this.existingData});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Back',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Container(
          color: Color.fromRGBO(204, 213, 174, 1),
          height: 1000,
          width: 10000,
          child: Padding(
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Title',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Data',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Payment Number',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              existingData.paymentid.toString(),
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Settlement Date',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              existingData.settlementDate.toString(),
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Withdrawn Amount',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              existingData.WithdrawnAmount.toString(),
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Settled Amount',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              existingData.settleamount.toString(),
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Refund Amount',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              existingData.refundamount.toString(),
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.home),
        iconSize: 70,
        color: Colors.black,
      ),
    );
  }
}
 
class PaymentTable extends StatelessWidget {
  final List<Payment> payments;
  final void Function(String) onRowSelected;
 
  const PaymentTable({required this.payments, required this.onRowSelected, key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    final filterPayment = payments.where((payment) => payment.pstatus == 'Posted').toList();
    return DataTable(
      columns: [
        DataColumn(label: Text('Payment No')),
        DataColumn(label: Text('Payment Date')),
        DataColumn(label: Text('Payment Amount')),
        DataColumn(label: Text('Payment Note')),
      ],
      rows: filterPayment.map((payment) {
        return DataRow(
          cells: [
            DataCell(Text(payment.pno)),
            DataCell(Text(payment.pdate)),
            DataCell(Text(payment.pmount.toString())),
            DataCell(Text(payment.pnote)),
          ],
          onSelectChanged: (bool? selected) {
            if (selected ?? false) {
              onRowSelected(payment.pno);
              Navigator.of(context).pop();
            }
          },
        );
      }).toList(),
    );
  }
}
 
 
