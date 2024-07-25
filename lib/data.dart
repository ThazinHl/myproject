
//data.dart
//For budgetCode
class Budget {
   final int id;
  final String code;
  final String description;
  final bool status;

  Budget(this.id,this.code, this.description,this.status);
}

List<Budget> getbcode() {
  return [
    Budget(1, 'B-001', 'Marketing',true),
    Budget(2,'B-002', 'Transport',false),
    Budget(3,'B-003', 'project',true),
  ];
}

          
//For  project
class Project {
   final int id;
  final String pcode;
  final String pdes;
 final List<String> bcode; // Assuming bcode is a list of strings (budget codes)
   final double tbmount;
  final String pcurrency;
  final double apmount;
   final String pstatus;
  final String preq;
 

  Project(this.id,this.pcode, this.pdes,this.bcode,this.tbmount,this.pcurrency,this.apmount,this.pstatus,this.preq);
}

List<Project > getproject() {
 

  return [
    Project(1, 'PRJ-2425-001','project', ['B-001', 'B-002', 'B-003'] ,1000,'USD',0,'Active','no'),
    Project(2,'PRJ-2425-002','project',['B-001'],100000,'MMK',0,'Active','no'),
    Project(3,'PRJ-2425-003','project', ['B-002'],500000,'MMK',0,'Active','yes'),
  ];
}

//For  Trip
class Trip {
   final int id;
  final String tcode;
  final String tdes;
  final List<String> bcode; // Assuming bcode is a list of strings (budget codes)
   final double tbmount;
  final String tcurrency;
  final double apmount;
   final String tstatus;
 

  Trip(this.id,this.tcode, this.tdes,this.bcode,this.tbmount,this.tcurrency,this.apmount,this.tstatus);
}

List<Trip > gettrip() {
  return [
    Trip(1, 'TRP-2425-001','travel',['B-001'] ,1000,'USD',0,'Active'),
    Trip(2,'TRP-2425-002','party',['B-001,B-002'] ,100000,'MMK',0,'Inactive'),
    Trip(3,'TRP-2425-003','party',['B-003'] ,500000,'MMK',0,'Active'),
  ];
}



          
//For Advance request
class Request {
  final int id;
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
 

  Request(this.id,this.rno, this.rcode,this.rmount,this.withdrawnmount,this.rcurrency,
  this.rpurpose,this.requester_id,this.rdate,this.approver1_id,this.approver2_id,this.approver3_id,this.approver_date,this.rstatus,this.rfile);
}

List<Request > getrequest() {
  return [
    Request(1,'Req-2425-001', 'PRJ-2425-001', 500000,300000,'MMK','First project request',1,'8/7/2024',1,1,2,'10/7/2024','Approved',''),
    Request(2,'Req-2425-002', 'PRJ-2425-003', 200000,100000,'MMK','Second project request',2,'9/7/2024',2,3,1,'10/7/2024','Pending',''),
   Request(3,'Req-2425-003', 'TRP-2425-002', 500,450,'USD','First Trip request',3,'9/7/2024',3,2,1,'11/7/2024','Rejected',''),
  ];
}       

    //For cash payment
    //data.dart
class Payment {
  final int id;
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
 

  Payment(this.id,this.pno, this.pdate,this.pmethod,this.wdmount,this.pmount,this.pcurrency,this.pstatus,this.pnote,this.preceive,this.ppaid,this.pfile);
}

List<Payment > getpayment() {
  return [
   Payment(1,'Req-2425-001-1', '8/7/2024','Cash',500000,300000,'MMK','Posted','for new project','Ma Ma','Hla',''),
    Payment(2,'Req-2425-001-2','8/7/2024','Cash',400000,100000,'MMK','Draft','for party','Yadanar','Zin',''),
  Payment(3,'Req-2425-001-3','10/7/2024','Cash',30000,10000,'USD','Posted','for travel','Pyae','Phoo Myat',''),
  ];
} 
