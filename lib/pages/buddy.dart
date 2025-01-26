import 'dart:convert';
import 'package:case_study/pages/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:case_study/models/subject.dart';

class BuddyPage extends StatefulWidget {
  const BuddyPage({super.key});
  @override
  _BuddyPageState createState() => _BuddyPageState();
}

class _BuddyPageState extends State<BuddyPage> {
  Map<String, dynamic>? userData;
  List<int> teachingSubjectIds = [];
  List<int> learningSubjectIds = [];

  @override
  void initState() {
    super.initState();
    loadUserData();
    loadSavedSubjects();
  }

  Future<void> loadUserData() async {
    String jsonString = await rootBundle.loadString('assets/mock/user.json');
    final jsonResponse = jsonDecode(jsonString);
    setState(() {
      userData = jsonResponse;
    });
  }

  Future<void> loadSavedSubjects() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      teachingSubjectIds = (prefs.getStringList('teachingSubjects') ?? [])
          .map((e) => int.parse(e))
          .toList();
      learningSubjectIds = (prefs.getStringList('learningSubjects') ?? [])
          .map((e) => int.parse(e))
          .toList();
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
                      builder: (context) => UserPage(
                          userData: userData!,
                          teachingSubjectIds: teachingSubjectIds,
                          learningSubjectIds: learningSubjectIds),
                    ),
                  );
                },
                child: Text('Go to User Page'),
              ),
      ),
    );
  }
}
