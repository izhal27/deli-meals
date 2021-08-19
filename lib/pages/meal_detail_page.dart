import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailPage extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function(String mealId) toggleFavorite;
  final bool Function(String meailId) isFavorite;

  MealDetailPage(this.toggleFavorite, this.isFavorite);

  Widget buildSectionTitle(BuildContext ctx, String text) {
    return Text(
      text,
      style: Theme.of(ctx).textTheme.headline1,
    );
  }

  Widget buildContainer({Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: buildSectionTitle(context, 'Ingredients'),
              ),
              buildContainer(
                child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Card(
                      color: Colors.black54,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Text(
                          selectedMeal.ingredients[index],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: selectedMeal.ingredients.length,
                ),
              ),
              buildSectionTitle(context, 'Steps'),
              buildContainer(
                child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Text('# ${(index + 1)}'),
                          ),
                          title: Text(selectedMeal.steps[index]),
                        ),
                        if (index != selectedMeal.steps.length - 1) Divider()
                      ],
                    );
                  },
                  itemCount: selectedMeal.steps.length,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child:
            Icon(isFavorite(mealId) ? Icons.favorite : Icons.favorite_border),
        onPressed: () => toggleFavorite(mealId),
      ),
    );
  }
}

// showAlertDialog(BuildContext context, String mealId) {
//   Widget cancelButton = TextButton(
//     child: Text("Cancel"),
//     onPressed: () => Navigator.of(context).pop(),
//   );
//   Widget continueButton = TextButton(
//     child: Text("Continue"),
//     onPressed: () {
//       Navigator.of(context).pop(); // close dialog
//       Navigator.of(context).pop(mealId);
//     },
//   );

//   AlertDialog alert = AlertDialog(
//     title: Text("Delete confirmation"),
//     content: Text("Are you sure you want to delete this item?"),
//     actions: [
//       cancelButton,
//       continueButton,
//     ],
//   );

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }
