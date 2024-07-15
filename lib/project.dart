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







//   import 'package:flutter/material.dart';

// class Projectinfo extends StatefulWidget {
//   const Projectinfo({super.key});

//   @override
//   _ProjectinfoState createState() => _ProjectinfoState();
// }

// class _ProjectinfoState extends State<Projectinfo> {
//   int _selectedValue = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Project Info'),
//       ),
//       body: Column(
//         children: [
//           RadioListTile<int>(
//             title: const Text('Project'),
//             value: 0,
//             groupValue: _selectedValue,
//             onChanged: (int? value) {
//               setState(() {
//                 _selectedValue = value!;
//               });
//             },
//           ),
//           RadioListTile<int>(
//             title: const Text('Trip'),
//             value: 1,
//             groupValue: _selectedValue,
//             onChanged: (int? value) {
//               setState(() {
//                 _selectedValue = value!;
//               });
//             },
//           ),
//           Expanded(
//             child: _selectedValue == 0
//                 ? const Center(child: Text('Project Screen'))
//                 : const Center(child: Text('Trip Screen')),
//           ),
//         ],
//       ),
//     );
//   }
// }



/*import 'package:flutter/material.dart';

class Projectinfo extends StatefulWidget {
  const Projectinfo({super.key});

  @override
  _ProjectinfoState createState() => _ProjectinfoState();
}

class _ProjectinfoState extends State<Projectinfo> {
  int _selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Info'),
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.fromLTRB(100, 0, 0, 0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: RadioListTile<int>(
                  title: const Text('Project'),
                  value: 0,
                  groupValue: _selectedValue,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedValue = value!;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<int>(
                  title: const Text('Trip'),
                  value: 1,
                  groupValue: _selectedValue,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedValue = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: _selectedValue == 0
                ? const Center(child: Text('Project Screen'))
                : const Center(child: Text('Trip Screen')),
          ),
        ],
      ),
    );
  }
}*/



