import 'package:flutter/material.dart';
import 'package:macro_ai/src/features/tracker/domain/food.dart';
import 'package:macro_ai/src/features/tracker/domain/meal_item.dart';

class EditMealItemModal extends StatefulWidget {
  final MealItem mealItem;
  final Function(MealItem) onSave;

  const EditMealItemModal(
      {super.key, required this.mealItem, required this.onSave});

  @override
  EditMealItemModalState createState() => EditMealItemModalState();
}

class EditMealItemModalState extends State<EditMealItemModal> {
  late TextEditingController _servingsController;
  late TextEditingController _foodNameController;
  late TextEditingController _caloriesController;
  late TextEditingController _proteinController;
  late TextEditingController _carbohydratesController;
  late TextEditingController _fatController;
  late TextEditingController _servingSizeController;

  @override
  void initState() {
    super.initState();
    _servingsController =
        TextEditingController(text: widget.mealItem.servings.toString());
    _foodNameController =
        TextEditingController(text: widget.mealItem.food.name);
    _caloriesController =
        TextEditingController(text: widget.mealItem.food.calories.toString());
    _proteinController =
        TextEditingController(text: widget.mealItem.food.protein.toString());
    _carbohydratesController = TextEditingController(
        text: widget.mealItem.food.carbohydrates.toString());
    _fatController =
        TextEditingController(text: widget.mealItem.food.fat.toString());
    _servingSizeController =
        TextEditingController(text: widget.mealItem.food.servingSize);
  }

  @override
  void dispose() {
    _servingsController.dispose();
    _foodNameController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbohydratesController.dispose();
    _fatController.dispose();
    _servingSizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _servingsController,
                decoration: const InputDecoration(labelText: 'Servings'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _foodNameController,
                decoration: const InputDecoration(labelText: 'Food Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _caloriesController,
                decoration: const InputDecoration(labelText: 'Calories'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _proteinController,
                decoration: const InputDecoration(labelText: 'Protein (g)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _carbohydratesController,
                decoration:
                    const InputDecoration(labelText: 'Carbohydrates (g)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _fatController,
                decoration: const InputDecoration(labelText: 'Fat (g)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _servingSizeController,
                decoration: const InputDecoration(labelText: 'Serving Size'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      final updatedFood = Food(
                        id: widget.mealItem.food.id,
                        name: _foodNameController.text,
                        calories: int.parse(_caloriesController.text),
                        protein: int.parse(_proteinController.text),
                        carbohydrates: int.parse(_carbohydratesController.text),
                        fat: int.parse(_fatController.text),
                        servingSize: _servingSizeController.text,
                      );

                      final updatedMealItem = MealItem(
                        id: widget.mealItem.id,
                        servings: double.parse(_servingsController.text),
                        food: updatedFood,
                      );

                      widget.onSave(updatedMealItem);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Function to show the modal
void showEditMealItemModal(
    BuildContext context, MealItem mealItem, Function(MealItem) onSave) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return EditMealItemModal(mealItem: mealItem, onSave: onSave);
    },
  );
}
