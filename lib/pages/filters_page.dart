import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersPage extends StatefulWidget {
  static const routeName = '/filters';
  final Function(Map<String, bool> filters) saveFilter;
  final Map<String, bool> currentFilters;

  FiltersPage(this.currentFilters, this.saveFilter);

  @override
  _FiltersPageState createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  initState() {
    super.initState();
    _glutenFree = widget.currentFilters['gluten'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    _lactoseFree = widget.currentFilters['lactose'];
  }

  Widget _buildSwitchListTile(
    String title,
    String subTitle,
    bool value,
    Function onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DeliMeals'),
        actions: [
          IconButton(
            onPressed: () {
              widget.saveFilter({
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Saved'),
                ),
              );
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchListTile(
                    'Gluten-free',
                    'Only include gluten-free meals',
                    _glutenFree,
                    (newValue) => setState(() => _glutenFree = newValue),
                  ),
                  _buildSwitchListTile(
                    'Vegetarian',
                    'Only include vegetarian meals',
                    _vegetarian,
                    (newValue) => setState(() => _vegetarian = newValue),
                  ),
                  _buildSwitchListTile(
                    'Vegan',
                    'Only include vegan meals',
                    _vegan,
                    (newValue) => setState(() => _vegan = newValue),
                  ),
                  _buildSwitchListTile(
                    'Lactose-free',
                    'Only include lactose-free meals',
                    _lactoseFree,
                    (newValue) => setState(() => _lactoseFree = newValue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
