import 'package:flutter/material.dart';

import './dummy_data.dart';
import './pages/categories_page.dart';
import './pages/category_meals_page.dart';
import './pages/filters_page.dart';
import './pages/meal_detail_page.dart';
import './pages/tabs_page.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  var _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }

        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }

        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }

        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _toggleFavorites(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex == -1) {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    } else {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }
  }

  bool _isFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.black,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline1: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
      // home: TabsPage(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsPage(_favoriteMeals),
        CategoryMealsPage.routeName: (ctx) => CategoryMealsPage(
              _availableMeals,
            ),
        MealDetailPage.routeName: (ctx) => MealDetailPage(
              _toggleFavorites,
              _isFavorite,
            ),
        FiltersPage.routeName: (ctx) => FiltersPage(_filters, _setFilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesPage());
      },
    );
  }
}
