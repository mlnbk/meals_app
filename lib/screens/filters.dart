import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/widgets/filter_item.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    final activeFilters = ref.read(filtersProvider);
    _glutenFreeFilterSet = activeFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = activeFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet = activeFilters[Filter.vegetarian]!;
    _veganFilterSet = activeFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          ref.read(filtersProvider.notifier).setFilters({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
          });
          return true;
        },
        child: Column(
          children: [
            FilterItem(
              isFilterSet: _glutenFreeFilterSet,
              onSetFilter: (active) {
                setState(() {
                  _glutenFreeFilterSet = active;
                });
              },
              title: 'Gluten-free',
              subtitle: 'Only include gluten-free meals.',
            ),
            FilterItem(
              isFilterSet: _lactoseFreeFilterSet,
              onSetFilter: (active) {
                setState(() {
                  _lactoseFreeFilterSet = active;
                });
              },
              title: 'Lactose-free',
              subtitle: 'Only include lactose-free meals.',
            ),
            FilterItem(
              isFilterSet: _vegetarianFilterSet,
              onSetFilter: (active) {
                setState(() {
                  _vegetarianFilterSet = active;
                });
              },
              title: 'Vegetarian',
              subtitle: 'Only include vegetarian meals.',
            ),
            FilterItem(
              isFilterSet: _veganFilterSet,
              onSetFilter: (active) {
                setState(() {
                  _veganFilterSet = active;
                });
              },
              title: 'Vegan',
              subtitle: 'Only include vegan meals.',
            ),
          ],
        ),
      ),
    );
  }
}
