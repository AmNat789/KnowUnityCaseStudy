import 'package:flutter/material.dart';

class FormattedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const FormattedAppBar({
    super.key,
    required this.title,
  });

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: Text(title,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 4,
      iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
