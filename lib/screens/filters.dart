import 'package:flutter/material.dart';
import 'package:meals_app/models/filters.dart';
import 'package:meals_app/widgets/filter_item.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.currentFilters,
  });

  final Map<String, bool> currentFilters;

  @override
  State<StatefulWidget> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  void initState() {
    super.initState();
    for (var filter in AvailableFilters) {
      filter.setIsActive(widget.currentFilters[filter.title] ?? false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            for (var filter in AvailableFilters) filter.title: filter.isActive
          });
          return false;
        },
        child: Column(
          children: [
            for (final filter in AvailableFilters)
              FilterItem(
                isFilterSet: filter.isActive,
                onSetFilter: (active) {
                  setState(() {
                    filter.setIsActive(active);
                  });
                },
                title: filter.title,
                subtitle: filter.subtitle,
              ),
          ],
        ),
      ),
    );
  }
}
