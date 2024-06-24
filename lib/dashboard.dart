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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Add new or view existing employees from here.'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.blue,
        // fixedColor: Colors.white,
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