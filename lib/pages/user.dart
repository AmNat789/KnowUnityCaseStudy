import 'package:case_study/widgets/subject_list.dart';
import 'package:case_study/widgets/subject_selection_list.dart';
import 'package:case_study/widgets/user_info_section.dart';

import 'package:case_study/models/subject.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  UserPage({required this.userData});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<Subject> teachingSubjects = [];
  List<Subject> learningSubjects = [];
  late List<Subject> subjects;

  @override
  void initState() {
    super.initState();
    subjects = (widget.userData['subjects'] as List)
        .map((subject) => Subject(
              id: subject['id'],
              name: subject['name'],
            ))
        .toList();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Page'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 4,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          UserInfoSection(userData: widget.userData),
          SubjectLists(
            teachingSubjects: teachingSubjects,
            learningSubjects: learningSubjects,
            onMoveToSubjects: moveToSubjects,
            onMoveToLearning: moveToLearning,
            onMoveToTeaching: moveToTeaching,
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
