import 'package:flutter/material.dart';
//import 'budget_code_screen.dart';
class Projectinfo extends StatelessWidget {
  const Projectinfo({super.key});
  @override
  Widget build(BuildContext context) {
   return  DefaultTabController(
    length: 2,
    child: Scaffold(
      appBar: AppBar(
        title: const TabBar(
          tabs: [
            Tab(text:('Project'),),
            Tab(text: ('Trip')),
           
          ],
        ),
      ),
      body:
       const TabBarView(
  children: [
    // BudgetCodeScreen(),
    Center(child: Text('Project Screen')),
     Center(child: Text('Trip Screen')),
  ],
),
    ),
  );
  }}



