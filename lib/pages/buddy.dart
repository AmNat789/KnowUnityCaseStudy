import 'dart:convert';
import 'package:case_study/models/models.dart';
import 'package:case_study/pages/user.dart';
import 'package:case_study/widgets/buddy_list.dart';
import 'package:case_study/widgets/formatted_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

class BuddyPage extends StatefulWidget {
  const BuddyPage({super.key});
  @override
  _BuddyPageState createState() => _BuddyPageState();
}

class _BuddyPageState extends State<BuddyPage> {
  Map<String, dynamic>? userData;
  List<Buddy>? buddiesData;
  List<int> teachingSubjectIds = [];
  List<int> learningSubjectIds = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
    loadSavedSubjects();
  }

  Future<void> loadJsonData() async {
    String userJsonString =
        await rootBundle.loadString('assets/mock/user.json');
    final userJsonResponse = jsonDecode(userJsonString);

    String buddiesJsonString =
        await rootBundle.loadString('assets/mock/buddies.json');
    final buddiesJsonResponse = jsonDecode(buddiesJsonString) as List;

    setState(() {
      userData = userJsonResponse;
      buddiesData =
          buddiesJsonResponse.map((buddy) => Buddy.fromJson(buddy)).toList();
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

  // This should be done on the Backend. Function just exists for demonstration purposes.
  List<Buddy> sortBuddies() {
    if (buddiesData == null ||
        (teachingSubjectIds.isEmpty && learningSubjectIds.isEmpty)) {
      return [];
    }

    List<Buddy> scoredBuddies = buddiesData!.map((buddy) {
      int score = 0;

      // Calculate matches for learningSubjectIds
      score += buddy.learningSubjects
          .where((subject) => teachingSubjectIds.contains(subject))
          .length;

      // Calculate matches for teachingSubjects
      score += buddy.teachingSubjects
          .where((subject) => learningSubjectIds.contains(subject))
          .length;

      return Buddy(
        name: buddy.name,
        id: buddy.id,
        score: score,
        teachingSubjects: buddy.teachingSubjects,
        learningSubjects: buddy.learningSubjects,
      );
    }).toList();

    // Sort buddies by score in descending order
    scoredBuddies.sort((a, b) => b.score!.compareTo(a.score!));

    return scoredBuddies;
  }

  @override
  Widget build(BuildContext context) {
    final sortedBuddies = sortBuddies();

    return Scaffold(
      appBar: FormattedAppBar(title: "Buddy Page"),
      body: Center(
        child: userData == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
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
                    child: Text('Customise your Subject Preferences'),
                  ),
                  if (sortedBuddies.isNotEmpty)
                    Expanded(
                      child: BuddyList(
                        buddies: sortedBuddies,
                        teachingSubjectIds: teachingSubjectIds,
                        learningSubjectIds: learningSubjectIds,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
