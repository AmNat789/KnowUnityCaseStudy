import 'package:case_study/widgets/formatted_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:case_study/models/models.dart';

class SubjectSelectionList extends StatelessWidget {
  final List<Subject> subjects;
  final Function(Subject) onMoveToLearning;
  final Function(Subject) onMoveToTeaching;

  const SubjectSelectionList({
    super.key,
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
        return FormattedListTile(
          leftIcon: Icon(Icons.add_circle_outline),
          onPressedLeft: () => onMoveToTeaching(subject),
          title: subject.name,
          rightIcon: Icon(Icons.add_circle_outline),
          onPressedRight: () => onMoveToLearning(subject),
        );
      },
    );
  }
}
