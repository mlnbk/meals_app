class Filter {
  Filter({
    this.isActive = false,
    required this.title,
    required this.subtitle,
  });

  bool isActive;
  final String title;
  final String subtitle;

  void setIsActive(bool active) {
    isActive = active;
  }
}

final AvailableFilters = [
  Filter(title: 'Gluten-free', subtitle: 'Only include gluten-free meals.'),
  Filter(title: 'Lactose-free', subtitle: 'Only include lactose-free meals.'),
  Filter(title: 'Vegatarian', subtitle: 'Only include vegetarian meals.'),
  Filter(title: 'Vegan', subtitle: 'Only include vegan meals.'),
];
