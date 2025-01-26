import 'package:case_study/models/models.dart';
import 'package:flutter/material.dart';

class BuddyList extends StatelessWidget {
  final List<Buddy> buddies;
  final List<int> teachingSubjectIds;
  final List<int> learningSubjectIds;

  const BuddyList({
    super.key,
    required this.buddies,
    required this.teachingSubjectIds,
    required this.learningSubjectIds,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.onSurface;

    List<int> matchedSubjects(List<int> l1, List<int> l2) =>
        l1.where((element) => l2.contains(element)).toList();

    return ListView.builder(
      itemCount: buddies.length,
      padding: EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        var buddy = buddies[index];
        var buddyCanTeachSubjects =
            matchedSubjects(buddy.teachingSubjects, learningSubjectIds);
        var buddyCanLearnSubjects =
            matchedSubjects(buddy.learningSubjects, teachingSubjectIds);

        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          margin: EdgeInsets.symmetric(vertical: 4.0),
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(buddy.name,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buddyCanTeachSubjects.isNotEmpty
                      ? Expanded(
                          child: Column(
                            children: [
                              Text("Can Teach:"),
                              Text(buddyCanTeachSubjects.toString())
                            ],
                          ),
                        )
                      : Expanded(child: Container()),
                  buddyCanLearnSubjects.isNotEmpty
                      ? Expanded(
                          child: Column(
                            children: [
                              Text("Needs Help With:"),
                              Text(buddyCanLearnSubjects.toString())
                            ],
                          ),
                        )
                      : Expanded(child: Container()),
                  Expanded(
                    child: IconButton(
                      onPressed: () => {},
                      icon: Icon(Icons.message),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
