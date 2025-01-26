import 'package:flutter/material.dart';
import 'package:case_study/models/subject.dart';

enum StudyRole { teaching, learning }

class SubjectLists extends StatelessWidget {
  final List<Subject> teachingSubjects;
  final List<Subject> learningSubjects;
  final Function(Subject) onMoveToSubjects;
  final Function(Subject)? onMoveToLearning;
  final Function(Subject)? onMoveToTeaching;

  SubjectLists({
    required this.teachingSubjects,
    required this.learningSubjects,
    required this.onMoveToSubjects,
    this.onMoveToLearning,
    this.onMoveToTeaching,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: StudyRoleList(
            title: 'Comfortable Teaching:',
            subjects: teachingSubjects,
            borderColor: Colors.blue,
            onMoveToLearning: onMoveToLearning,
            onMoveToSubjects: onMoveToSubjects,
            role: StudyRole.teaching,
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: StudyRoleList(
            title: 'Need Help Learning:',
            subjects: learningSubjects,
            borderColor: Colors.red,
            onMoveToTeaching: onMoveToTeaching,
            onMoveToSubjects: onMoveToSubjects,
            role: StudyRole.learning,
          ),
        ),
      ],
    );
  }
}

class StudyRoleList extends StatelessWidget {
  final String title;
  final List<Subject> subjects;
  final Color borderColor;
  final StudyRole role;
  final Function(Subject)? onMoveToLearning;
  final Function(Subject) onMoveToSubjects;
  final Function(Subject)? onMoveToTeaching;

  StudyRoleList({
    required this.title,
    required this.subjects,
    required this.borderColor,
    this.onMoveToLearning,
    this.onMoveToTeaching,
    required this.onMoveToSubjects,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
          ),
          child: Column(
            children: [
              Text(title),
              for (var subject in subjects)
                ListTile(
                  leading: role == StudyRole.teaching
                      ? IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 16,
                          icon: Icon(Icons.arrow_downward),
                          onPressed: () => onMoveToSubjects(subject),
                        )
                      : IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 16,
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => onMoveToTeaching!(subject),
                        ),
                  title: Flexible(
                    child: Text(
                      subject.name,
                      softWrap: false,
                    ),
                  ),
                  trailing: role == StudyRole.teaching
                      ? IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 16,
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () => onMoveToLearning!(subject),
                        )
                      : IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 16,
                          icon: Icon(Icons.arrow_downward),
                          onPressed: () => onMoveToSubjects(subject),
                        ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
