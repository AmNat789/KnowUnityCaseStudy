import 'package:case_study/pages/buddy.dart';
import 'package:case_study/widgets/subject_list.dart';
import 'package:case_study/widgets/subject_selection_list.dart';
import 'package:case_study/widgets/user_info_section.dart';
import 'package:case_study/models/subject.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  final List<int> teachingSubjectIds;
  final List<int> learningSubjectIds;

  const UserPage({
    super.key,
    required this.userData,
    required this.teachingSubjectIds,
    required this.learningSubjectIds,
  });

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<Subject> teachingSubjects = [];
  List<Subject> learningSubjects = [];
  List<Subject> subjects = [];

  @override
  void initState() {
    super.initState();
    initializeSubjects();
  }

  void initializeSubjects() {
    for (var userDataSubject in widget.userData['subjects']) {
      var subject = Subject(
        id: userDataSubject['id'],
        name: userDataSubject['name'],
      );

      if (widget.teachingSubjectIds.contains(userDataSubject['id'])) {
        teachingSubjects.add(subject);
      } else if (widget.learningSubjectIds.contains(userDataSubject['id'])) {
        learningSubjects.add(subject);
      } else {
        subjects.add(subject);
      }
    }
    setState(() {});
  }

  void moveToTeaching(Subject subject) {
    setState(() {
      learningSubjects.remove(subject);
      teachingSubjects.add(subject);
      subjects.remove(subject);
    });
  }

  void moveToLearning(Subject subject) {
    setState(() {
      teachingSubjects.remove(subject);
      learningSubjects.add(subject);
      subjects.remove(subject);
    });
  }

  void moveToSubjects(Subject subject) {
    setState(() {
      if (teachingSubjects.contains(subject)) {
        teachingSubjects.remove(subject);
      } else if (learningSubjects.contains(subject)) {
        learningSubjects.remove(subject);
      }
      subjects.add(subject);
    });
  }

  Future<void> saveSubjects() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> teachingSubjectsIds =
        teachingSubjects.map((s) => s.id.toString()).toList();
    List<String> learningSubjectsIds =
        learningSubjects.map((s) => s.id.toString()).toList();
    await prefs.setStringList('teachingSubjects', teachingSubjectsIds);
    await prefs.setStringList('learningSubjects', learningSubjectsIds);

    if (mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BuddyPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Page',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 4,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Material(
            color: Theme.of(context).colorScheme.secondary,
            elevation: 4,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      UserInfoSection(userData: widget.userData),
                      SizedBox(width: 32),
                      ElevatedButton(
                        onPressed: saveSubjects,
                        child: Text('Save'),
                      ),
                    ],
                  ),
                ),
                SubjectLists(
                  teachingSubjects: teachingSubjects,
                  learningSubjects: learningSubjects,
                  onMoveToSubjects: moveToSubjects,
                  onMoveToLearning: moveToLearning,
                  onMoveToTeaching: moveToTeaching,
                ),
              ],
            ),
          ),
          Expanded(
            child: SubjectSelectionList(
              subjects: subjects,
              onMoveToLearning: moveToLearning,
              onMoveToTeaching: moveToTeaching,
            ),
          ),
        ],
      ),
    );
  }
}
