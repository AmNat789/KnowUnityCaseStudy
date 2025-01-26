import 'dart:convert';
import 'package:case_study/pages/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class BuddyPage extends StatefulWidget {
  const BuddyPage({super.key});
  @override
  _BuddyPageState createState() => _BuddyPageState();
}

class _BuddyPageState extends State<BuddyPage> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    String jsonString = await rootBundle.loadString('assets/mock/user.json');
    final jsonResponse = jsonDecode(jsonString);
    setState(() {
      userData = jsonResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buddy Page'),
      ),
      body: Center(
        child: userData == null
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserPage(userData: userData!),
                    ),
                  );
                },
                child: Text('Go to User Page'),
              ),
      ),
    );
  }
}
