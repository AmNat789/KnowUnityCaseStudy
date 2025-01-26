import 'dart:convert';
import 'package:case_study/pages/user.dart';
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
  List<Map<String, dynamic>>? buddiesData;
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
    final buddiesJsonResponse =
        List<Map<String, dynamic>>.from(jsonDecode(buddiesJsonString));

    setState(() {
      userData = userJsonResponse;
      buddiesData = List<Map<String, dynamic>>.from(buddiesJsonResponse);
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
  List<Map<String, dynamic>> sortBuddies() {
    if (buddiesData == null ||
        (teachingSubjectIds.isEmpty && learningSubjectIds.isEmpty)) {
      return [];
    }
    List<Map<String, dynamic>> scoredBuddies = buddiesData!.map((buddy) {
      num score = 0;

      // Calculate matches for learningSubjectIds
      score += buddy['learningSubjects']
          .where((subject) => teachingSubjectIds.contains(subject))
          .length;

      // Calculate matches for teachingSubjects
      score += buddy['teachingSubjects']
          .where((subject) => learningSubjectIds.contains(subject))
          .length;

      // Add score to buddy data
      return {
        ...buddy,
        'score': score,
      };
    }).toList();

    // Sort buddies by score in descending order
    scoredBuddies.sort((a, b) => b['score'].compareTo(a['score']));

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
                      child: SingleChildScrollView(
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('Teaching Subject IDs')),
                            DataColumn(label: Text('Learning Subject IDs')),
                            DataColumn(label: Text('Score')),
                          ],
                          rows: [
                            for (var buddy in sortedBuddies)
                              DataRow(
                                cells: [
                                  DataCell(Text(buddy['name'])),
                                  DataCell(Text(buddy['teachingSubjects']
                                      .map((e) => e.toString())
                                      .join(', '))),
                                  DataCell(Text(buddy['learningSubjects']
                                      .map((e) => e.toString())
                                      .join(', '))),
                                  DataCell(Text(buddy['score'].toString())),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
