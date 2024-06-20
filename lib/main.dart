import 'package:employee/add_user.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the main screen after 3 seconds
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/user.png'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Verification'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Add a new user or scan an existing one'),
            const SizedBox(height: 20),
           Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddUser()));
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SplashScreen(),
  ));
}