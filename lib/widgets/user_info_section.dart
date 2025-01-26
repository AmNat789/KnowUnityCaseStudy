import 'package:flutter/material.dart';

class UserInfoSection extends StatelessWidget {
  final Map<String, dynamic> userData;

  const UserInfoSection({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = TextStyle(
        fontSize: 16.0, color: Theme.of(context).colorScheme.onSurface);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ID: ${userData['id']}', style: titleStyle),
        Text('Name: ${userData['name']}', style: titleStyle),
        Text('Curriculum: ${userData['curriculum']}', style: titleStyle),
        Text('Year: ${userData['year']}', style: titleStyle),
      ],
    );
  }
}
