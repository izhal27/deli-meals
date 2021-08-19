import 'package:flutter/material.dart';

import './categories_page.dart';
import './favorites_page.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';

class TabsPage extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabsPage(this.favoriteMeals);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      {
        'page': CategoriesPage(),
        'title': 'Categories',
      },
      {
        'page': FavoritesPage(widget.favoriteMeals),
        'title': 'Your Favorites',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final selectedPage = _pages[_selectedPageIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPage['title']),
      ),
      drawer: MainDrawer(),
      body: selectedPage['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
