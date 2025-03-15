import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macro_ai/src/features/tracker/data/meal_repository_provider.dart';
import 'package:macro_ai/src/features/tracker/domain/meal_item.dart';
import 'package:macro_ai/src/features/tracker/presentation/meal_edit_modal.dart';

class MealMacros {
  const MealMacros({required this.items});
  final List<MealItem> items;

  int get calories => items.fold(
      0, (total, item) => total + (item.food.calories * item.servings).toInt());
  int get protein => items.fold(
      0, (total, item) => total + (item.food.protein * item.servings).toInt());
  int get carbohydrates => items.fold(
      0,
      (total, item) =>
          total + (item.food.carbohydrates * item.servings).toInt());
  int get fat => items.fold(
      0, (total, item) => total + (item.food.fat * item.servings).toInt());
}

class MealDisplay extends ConsumerWidget {
  const MealDisplay(
      {required this.mealId,
      required this.mealName,
      required this.mealItems,
      super.key});
  final int mealId;
  final String mealName;
  final List<MealItem> mealItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final macros = MealMacros(items: mealItems);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        ListTile(
          title: Text(
            mealName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: colorScheme.error),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Delete Meal'),
                  content: Text(
                      "Are you sure you want to delete meal: '$mealName'?"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ref.read(deleteMealProvider(mealId));
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        ...mealItems.map((item) => MealItemDisplay(mealItem: item)),
        ListTile(
          title: Text(
              'Protein: ${macros.protein}g | Fat: ${macros.fat}g | Carbs: ${macros.carbohydrates}g'),
          trailing: Text('${macros.calories} kcal'),
        ),
      ],
    );
  }
}

class MealItemDisplay extends ConsumerStatefulWidget {
  const MealItemDisplay({required this.mealItem, super.key});
  final MealItem mealItem;

  @override
  ConsumerState<MealItemDisplay> createState() => _MealItemDisplayState();
}

class _MealItemDisplayState extends ConsumerState<MealItemDisplay> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Dismissible(
      key: ValueKey(widget.mealItem),
      direction: DismissDirection.endToStart,
      background: Container(
        color: colorScheme.secondary,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        showEditMealItemModal(context, widget.mealItem, (mealItem) {
          ref.read(editMealItemProvider(mealItem));
        });
        return false;
      },
      child: GestureDetector(
        onTap: () {
          showEditMealItemModal(context, widget.mealItem, (mealItem) {
            ref.read(editMealItemProvider(mealItem));
          });
        },
        child: ListTile(
          title: Text(widget.mealItem.food.name),
          leading: Text('${widget.mealItem.servings}x'),
          subtitle: Text(widget.mealItem.food.servingSize),
          trailing: Text('${widget.mealItem.food.calories} kcal'),
        ),
      ),
    );
  }
}
