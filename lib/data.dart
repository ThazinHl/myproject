
//data.dart
//For budgetCode
class Budget {
  final String code;
  final String description;
  final String status;

  Budget(this.code, this.description,this.status);
}

List<Budget> getbcode() {
  return [
    Budget( 'B-001', 'Marketing','Active'),
    Budget('B-002', 'Transport','Inactive'),
    Budget('B-003', 'project','Active'),
  ];
}

          
//For  project
class Project {
  final String pcode;
  final String pdes;
  final String bcode;
   final String tbmount;
  final String pcurrency;
  final String apmount;
   final String pstatus;
  final String preq;
 

  Project(this.pcode, this.pdes,this.bcode,this.tbmount,this.pcurrency,this.apmount,this.pstatus,this.preq);
}

List<Project > getproject() {
  return [
    Project( 'PRJ-2425-001','project','B-001' ,'1000','USD','0','Active','no'),
    Project('PRJ-2425-002','project','B-001,B-002' ,'100000','MMK','0','Active','no'),
    Project('PRJ-2425-003','project','B-003' ,'500000','MMK','0','Active','yes'),
  ];
}

//For  Trip
class Trip {
  final String tcode;
  final String tdes;
  final String bcode;
   final String tbmount;
  final String tcurrency;
  final String apmount;
   final String tstatus;
 

  Trip(this.tcode, this.tdes,this.bcode,this.tbmount,this.tcurrency,this.apmount,this.tstatus);
}

List<Trip > gettrip() {
  return [
    Trip( 'TRP-2425-001','travel','B-001' ,'1000','USD','0','Active'),
    Trip('TRP-2425-002','party','B-001,B-002' ,'100000','MMK','0','Inactive'),
    Trip('TRP-2425-003','party','B-003' ,'500000','MMK','0','Active'),
  ];
}



          
//For Advance request
class Request {
  final String rno;
  final String rcode;
  final String rmount;
   final String rcurrency;
  final String rpurpose;
  final String rdate;
   final String rstatus;
  final String rfile;
 

  Request(this.rno, this.rcode,this.rmount,this.rcurrency,this.rpurpose,this.rdate,this.rstatus,this.rfile);
}

List<Request > getrequest() {
  return [
    Request('Req-2425-001', 'PRJ-2425-001', '500000','MMK','First project request','8/7/2024','Approved',''),
    Request('Req-2425-002', 'PRJ-2425-003', '200000','MMK','Second project request','9/7/2024','Pending',''),
   Request('Req-2425-003', 'TRP-2425-002', '500','USD','First Trip request','9/7/2024','Rejected',''),
  ];
}       

    //For cash payment
class Payment {
  final String pno;
  final String pdate;
  final String pmethod;
  final String pmount;
  final String pcurrency;
  final String pstatus;
  
 

  Payment(this.pno, this.pdate,this.pmethod,this.pmount,this.pcurrency,this.pstatus);
}

List<Payment > getpayment() {
  return [
   Payment('Req-2425-001-1', '8/7/2024','Cash','300000','MMK','Posted'),
    Payment('Req-2425-001-2','8/7/2024','Cash','100000','MMK','Draft'),
  Payment('Req-2425-001-3','10/7/2024','Cash','10000','USD','Posted'),
  ];
} 
