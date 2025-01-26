import 'package:flutter/material.dart';

class FormattedIconButton extends StatelessWidget {
  final Icon icon;
  final Function() onPressed;

  const FormattedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  IconButton build(BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: onPressed,
      iconSize: 16,
      constraints: BoxConstraints(
        minWidth: 16,
        minHeight: 16,
      ),
      padding: EdgeInsets.all(8.0),
    );
  }
}

class FormattedListTile extends StatelessWidget {
  final Icon leftIcon;
  final Function() onPressedLeft;
  final String title;
  final Icon rightIcon;
  final Function() onPressedRight;
  final Color? textAndIconColor;

  const FormattedListTile({
    super.key,
    required this.leftIcon,
    required this.onPressedLeft,
    required this.title,
    required this.rightIcon,
    required this.onPressedRight,
    this.textAndIconColor,
  });

  @override
  ListTile build(BuildContext context) {
    return ListTile(
      leading: FormattedIconButton(
        icon: leftIcon,
        onPressed: onPressedLeft,
      ),
      title: Center(
        child: Text(
          title,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: textAndIconColor,
          ),
        ),
      ),
      trailing: FormattedIconButton(
        icon: rightIcon,
        onPressed: onPressedRight,
      ),
    );
  }
}
