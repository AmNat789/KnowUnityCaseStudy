import 'package:flutter/material.dart';
import 'package:case_study/models/subject.dart';

class SubjectSelectionList extends StatelessWidget {
  final List<Subject> subjects;
  final Function(Subject) onMoveToLearning;
  final Function(Subject) onMoveToTeaching;

  SubjectSelectionList({
    required this.subjects,
    required this.onMoveToLearning,
    required this.onMoveToTeaching,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];
        return ListTile(
          leading: IconButton(
            icon: Icon(Icons.arrow_upward),
            onPressed: () {
              onMoveToTeaching(subject);
            },
          ),
          title: Center(
            child: Text(
              subject.name,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.arrow_upward),
            onPressed: () {
              onMoveToLearning(subject);
            },
          ),
        );
      },
    );
  }
}
