import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<String, bool> _selectedFilters = {};

  void _toggleFavorite(Meal meal) {
    if (_favoriteMeals.contains(meal)) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favorite.');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage('Meal added to favorites.');
    }
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String id) async {
    Navigator.of(context).pop();

    if (id == 'filters') {
      final result = await Navigator.of(context).push<Map<String, bool>>(
        MaterialPageRoute(
          builder: (context) => FiltersScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );

      if (result != null) {
        setState(() {
          _selectedFilters = result;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // FIXME
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters['Gluten-free'] != null &&
          _selectedFilters['Gluten-free']! &&
          !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters['Lactose-free'] != null &&
          _selectedFilters['Lactose-free']! &&
          !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters['Vegatarian'] != null &&
          _selectedFilters['Vegatarian']! &&
          !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters['Vegan'] != null &&
          _selectedFilters['Vegan']! &&
          !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleFavorite,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleFavorite,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
