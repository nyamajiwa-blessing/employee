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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EmployeeDetailsScreen()),
                  );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(250, 50)
              ),
              child: const Text('ADD NEW USER'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ResultsTable()),
                  );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(250, 50)
              ),
              child: const Text('VIEW USERS'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add your button functionality here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(250, 50)
              ),
              child: const Text('Button 3'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add your button functionality here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(250, 50)
              ),
              child: const Text('Button 4'),
            ),
          ],
        ),
      ),
    );
  }
}