import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.function,
  });

  final IconData icon;
  final String label;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => function(),
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.secondary,
      ),
      title: Text(
        label,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
