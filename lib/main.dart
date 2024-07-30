/*
import 'package:flutter/material.dart';
import 'package:myproject/payment.dart';
//import 'package:myproject/request.dart';
import 'budget_code_screen.dart';
import 'project.dart';
import 'request.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
     Center(child: Text('Advance Request Management')),
     BudgetCodeScreen(),
     Projectinfo(),
    RequestScreen(),
    PaymentScreen(),
    Center(child: Text('Settlement Screen')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       leading: 
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              _onItemTapped(0);
            },
          ),
        
       
         titleTextStyle: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
centerTitle:true,
      title:const Text('Advance Request Management',style:TextStyle(color:Colors.white)),
        backgroundColor:const Color.fromARGB(255, 152, 189, 202),

        
      ),
      // drawer:Drawer(
      //   backgroundColor: const Color.fromARGB(255, 152, 189, 202),
      // child: ListView(
      //  // padding: EdgeInsets.zero,
      //         children: <Widget>[
      //          ListTile(
      //             leading:const  Icon(Icons.home, color: Colors.white),
      //             title:const  Text('Home', style: TextStyle(color: Color.fromARGB(255, 252, 251, 251))),
      //             onTap: () {
      //               _onItemTapped(0);
      //             },
      //           ),
      //           ListTile(
      //             leading:const  Icon(Icons.code, color: Colors.white),
      //             title:const  Text('Budget Codes', style: TextStyle(color: Color.fromARGB(255, 252, 251, 251))),
      //             onTap: () {
      //               _onItemTapped(1);
      //             },
      //           ),
      //           ListTile(
      //             leading:const Icon(Icons.medical_information, color: Colors.white),
      //             title:const Text('Project Information', style: TextStyle(color: Colors.white)),
      //             onTap: () {
      //               _onItemTapped(2);
      //             },
      //           ),
      //           ListTile(
      //             leading: const Icon(Icons.request_page, color: Colors.white),
      //             title: const Text('Advance Request', style: TextStyle(color: Colors.white)),
      //             onTap: () {
      //               _onItemTapped(3);
      //             },
      //           ),
      //           ListTile(
      //             leading: const Icon(Icons.payment, color: Colors.white),
      //             title: const Text('Cash Payment', style: TextStyle(color: Colors.white)),
      //             onTap: () {
      //               _onItemTapped(4);
      //             },
      //           ),
      //           ListTile(
      //             leading: const Icon(Icons.print, color: Colors.white),
      //             title: const Text('Settlement', style: TextStyle(color: Colors.white)),
      //             onTap: () {
      //               _onItemTapped(5);
      //             },
      //           ),
      //         ],
      //       ),
          
      // ),
      body: Row(
        children: <Widget>[
          Container(
            width: 200.0,
            color: const Color.fromARGB(255, 152, 189, 202),
            child: Column(
              children: <Widget>[
              //  ListTile(
              //     leading:const  Icon(Icons.home, color: Colors.white),
              //     title:const  Text('Home', style: TextStyle(color: Color.fromARGB(255, 252, 251, 251))),
              //     onTap: () {
              //       _onItemTapped(0);
              //     },
              //   ),
                ListTile(
                  leading:const  Icon(Icons.code, color: Colors.white),
                  title:const  Text('Budget Codes', style: TextStyle(color: Color.fromARGB(255, 252, 251, 251))),
                  onTap: () {
                    _onItemTapped(1);
                  },
                ),
                ListTile(
                  leading:const Icon(Icons.medical_information, color: Colors.white),
                  title:const Text('Project Information', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    _onItemTapped(2);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.request_page, color: Colors.white),
                  title: const Text('Advance Request', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    _onItemTapped(3);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.payment, color: Colors.white),
                  title: const Text('Cash Payment', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    _onItemTapped(4);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.print, color: Colors.white),
                  title: const Text('Settlement', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    _onItemTapped(5);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          //Container(width:200, color: Color.fromARGB(255, 152, 189, 202),child:Text('dddddd')),
        ],
      ),
    );
  }
}*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myproject/payment.dart';
import 'budget_code_screen.dart';
import 'project.dart';
import 'request.dart';
import 'settlement.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  bool isSidebarOpen =false;
  int _selectedIndex=0;

  static List<Widget> _widgetOptions= <Widget>[
    Center(child: (Text('Welcome', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40,) ,)),),
    BudgetCodeScreen(), 
    Projectinfo(),
    RequestScreen(),
    PaymentScreen(),
    //Center(child: (Text('Settlement')),),
    Settlement(),

  ];

  @override
  void initState() {
    super.initState();
    _controller= AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      
      );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSidebar(){
    setState(() {
      if (isSidebarOpen) {
        _controller.reverse();
      }else{
        _controller.forward();
      }
      isSidebarOpen=!isSidebarOpen;
    });
  }

  void _onItemTapped(int index){
   setState((){
     _selectedIndex= index;
    _toggleSidebar();
   });
  }

  // void _logout(){
    
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          
          toolbarHeight: 100,
          title: const Text('Advance Request Information', style: TextStyle(color: Colors.black, fontSize:30, fontWeight: FontWeight.bold),),
          leading: IconButton(onPressed: _toggleSidebar, 
          icon:AnimatedIcon(icon: AnimatedIcons.menu_close, progress: _controller)),

        actions:const <Widget>[
          IconButton(
            padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
            
            icon: 
            Icon(Icons.logout),
            tooltip: 'Log out',
            color: Colors.black,
            onPressed: null, 
            )
        ],
          
       
        ),
        body: Stack(
          
          children: [
            Container(
            color: Color.fromRGBO(204, 213, 174, 1),

             child: _widgetOptions.elementAt(_selectedIndex),

            ),
      
            
            if(isSidebarOpen)
            GestureDetector(
              onTap: _toggleSidebar,
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: isSidebarOpen ? 0 :-250,
            top: 0,
          bottom: 0,
          child: SizedBox(
              width: 250,
              child:
              CustomDrawer(
                onItemTapped:_onItemTapped,
              )
            ) 
            ),
            
          ],
          
        ),
      ),
      ) ;
  }
}

class CustomDrawer extends StatefulWidget {
  final ValueChanged<int> onItemTapped;
   const CustomDrawer({super.key, required this.onItemTapped});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: 300,
        color: Colors.grey.shade300,

        child: 
        Column(
          children: [

            Padding(padding:  const EdgeInsets.symmetric(vertical: 8.0),
            child:ListTile(
              leading: Icon(Icons.code),
              title: Text('Budget Code', style: TextStyle(fontSize: 20),),
              onTap: () => widget.onItemTapped(1),


            ),
            ),

          Padding(padding:  const EdgeInsets.symmetric(vertical: 8.0),
            child:ListTile(
              leading: Icon(Icons.info),
              title: Text('Project Information', style: TextStyle(fontSize: 20),),
              onTap: () => widget.onItemTapped(2),

            ),
          ),

          Padding(padding:  const EdgeInsets.symmetric(vertical: 8.0),
            child:ListTile(
              leading: Icon(Icons.request_page),
              title: Text('Advance Request', style: TextStyle(fontSize: 20),),
              onTap: () => widget.onItemTapped(3),

            ),
          ),


          Padding(padding:  const EdgeInsets.symmetric(vertical: 8.0),
            child:ListTile(
              leading: Icon(Icons.payment),
              title: Text('Cash Payment', style: TextStyle(fontSize: 20),),
              onTap: () => widget.onItemTapped(4),

            ),
          ),

          Padding(padding:  const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(Icons.print),
              title: Text('Settlement', style: TextStyle(fontSize: 20),),
              onTap: () => widget.onItemTapped(5),

            ),
          ),
          ],
        ),
      )
    );
  }
}

