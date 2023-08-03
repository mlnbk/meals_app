import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/widgets/filter_item.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          FilterItem(
            isFilterSet: activeFilters[Filter.glutenFree]!,
            onSetFilter: (active) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, active);
            },
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free meals.',
          ),
          FilterItem(
            isFilterSet: activeFilters[Filter.lactoseFree]!,
            onSetFilter: (active) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, active);
            },
            title: 'Lactose-free',
            subtitle: 'Only include lactose-free meals.',
          ),
          FilterItem(
            isFilterSet: activeFilters[Filter.vegetarian]!,
            onSetFilter: (active) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, active);
            },
            title: 'Vegetarian',
            subtitle: 'Only include vegetarian meals.',
          ),
          FilterItem(
            isFilterSet: activeFilters[Filter.vegan]!,
            onSetFilter: (active) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, active);
            },
            title: 'Vegan',
            subtitle: 'Only include vegan meals.',
          ),
        ],
      ),
    );
  }
}
