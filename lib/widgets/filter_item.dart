import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.isFilterSet,
    required this.onSetFilter,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;
  final bool isFilterSet;
  final void Function(bool) onSetFilter;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: isFilterSet,
      onChanged: onSetFilter,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
