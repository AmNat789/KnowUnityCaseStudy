import 'package:case_study/widgets/formatted_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:case_study/models/subject.dart';

enum StudyRole { teaching, learning }

class SubjectLists extends StatelessWidget {
  final List<Subject> teachingSubjects;
  final List<Subject> learningSubjects;
  final Function(Subject) onMoveToSubjects;
  final Function(Subject) onMoveToLearning;
  final Function(Subject) onMoveToTeaching;

  const SubjectLists({
    super.key,
    required this.teachingSubjects,
    required this.learningSubjects,
    required this.onMoveToSubjects,
    required this.onMoveToLearning,
    required this.onMoveToTeaching,
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
            onMoveToOtherStudyRole: onMoveToLearning,
            onMoveToSubjects: onMoveToSubjects,
            role: StudyRole.teaching,
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: StudyRoleList(
            title: 'Need Help Learning:',
            subjects: learningSubjects,
            onMoveToOtherStudyRole: onMoveToTeaching,
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
  final StudyRole role;
  final Function(Subject) onMoveToOtherStudyRole;
  final Function(Subject) onMoveToSubjects;

  const StudyRoleList({
    super.key,
    required this.title,
    required this.subjects,
    required this.onMoveToOtherStudyRole,
    required this.onMoveToSubjects,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.onSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            for (var subject in subjects)
              FormattedListTile(
                leftIcon: role == StudyRole.teaching
                    ? Icon(Icons.arrow_downward, color: color)
                    : Icon(Icons.arrow_back, color: color),
                onPressedLeft: role == StudyRole.teaching
                    ? () => onMoveToSubjects(subject)
                    : () => onMoveToOtherStudyRole(subject),
                title: subject.name,
                rightIcon: role == StudyRole.teaching
                    ? Icon(Icons.arrow_forward, color: color)
                    : Icon(Icons.arrow_downward, color: color),
                onPressedRight: role == StudyRole.teaching
                    ? () => onMoveToOtherStudyRole(subject)
                    : () => onMoveToSubjects(subject),
                textAndIconColor: color,
              ),
          ],
        ),
      ],
    );
  }
}
