import 'package:flutter/material.dart';

import '../pages/filters_page.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10,
            ),
            alignment: Alignment.centerLeft,
            // color: Theme.of(context).accentColor,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Divider(),
          buildListTile(
            'Meals',
            Icons.restaurant,
            () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          buildListTile(
            'Filters',
            Icons.settings,
            () => Navigator.of(context)
                .pushReplacementNamed(FiltersPage.routeName),
          ),
        ],
      ),
    );
  }
}
