import 'package:employee/details.dart';
import 'package:employee/view_users.dart';
import 'package:flutter/material.dart';

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       ElevatedButton(
      //         onPressed: () {
      //           Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                   builder: (context) => const EmployeeDetailsScreen()),
      //             );
      //         },
      //         style: ElevatedButton.styleFrom(
      //           backgroundColor: Colors.blue,
      //           foregroundColor: Colors.white,
      //           minimumSize: const Size(250, 50),
      //         ),
      //         child: const Text('Add Employee'),
      //       ),
      //       const SizedBox(height: 16),
      //       ElevatedButton(
      //         onPressed: () {
      //           Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                   builder: (context) => const ResultsTable()),
      //             );
      //         },
      //         style: ElevatedButton.styleFrom(
      //           backgroundColor: Colors.blue,
      //           foregroundColor: Colors.white,
      //           minimumSize: const Size(250, 50),
      //         ),
      //         child: const Text('View Users'),
      //       ),
      //     ],
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        fixedColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Employee',
          ),
          BottomNavigationBarItem(
            // backgroundColor: Colors.white,
            icon: Icon(Icons.list),
            label: 'View Users',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EmployeeDetailsScreen()),
                );
              break;
            case 1:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ResultsTable()),
                );
              break;
          }
        },
      ),
    );
  }
}