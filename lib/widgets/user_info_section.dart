import 'package:flutter/material.dart';

class UserInfoSection extends StatelessWidget {
  final Map<String, dynamic> userData;

  UserInfoSection({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: Container(
        width: double.infinity,
        color: Theme.of(context)
            .colorScheme
            .primary
            .withAlpha((0.5 * 255).toInt()),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${userData['id']}'),
            Text('Name: ${userData['name']}'),
            Text('Curriculum: ${userData['curriculum']}'),
            Text('Year: ${userData['year']}'),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
