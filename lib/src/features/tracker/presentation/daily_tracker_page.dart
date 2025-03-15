import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:macro_ai/src/features/tracker/data/meal_repository_provider.dart';
import 'package:macro_ai/src/features/tracker/data/selected_date_provider.dart';
// import 'package:go_router/go_router.dart';
import 'package:macro_ai/src/features/tracker/domain/meal.dart';
import 'package:macro_ai/src/features/tracker/domain/meal_item.dart';
import 'package:macro_ai/src/features/tracker/presentation/input_box.dart';
import 'package:macro_ai/src/features/tracker/presentation/meal_display.dart';

class DailyTrackerPage extends ConsumerWidget {
  const DailyTrackerPage({super.key});

  String _getDisplayDate(DateTime selectedDate) {
    final now = DateTime.now();
    if (selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day) {
      return 'Today';
    } else if (selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day + 1) {
      return 'Tomorrow';
    } else if (selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day - 1) {
      return 'Yesterday';
    } else {
      return DateFormat('E, MMM d').format(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final mealsAsync = ref.watch(mealsProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () =>
                    ref.read(selectedDateProvider.notifier).changeDate(-1),
              ),
              GestureDetector(
                onTap: () => _showDatePicker(context, ref, selectedDate),
                child: Text(
                  _getDisplayDate(selectedDate),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () =>
                    ref.read(selectedDateProvider.notifier).changeDate(1),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: mealsAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('Error: $error')),
                  data: (meals) {
                    int totalCalories = 0;
                    int totalProtein = 0;
                    int totalCarbohydrates = 0;
                    int totalFats = 0;

                    for (Meal meal in meals) {
                      for (MealItem item in meal.items) {
                        totalCalories +=
                            (item.food.calories * item.servings).toInt();
                        totalProtein +=
                            (item.food.protein * item.servings).toInt();
                        totalCarbohydrates +=
                            (item.food.carbohydrates * item.servings).toInt();
                        totalFats += (item.food.fat * item.servings).toInt();
                      }
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text('Protein'),
                            trailing: Text('${totalProtein}g'),
                          ),
                          ListTile(
                            title: const Text('Carbohydrates'),
                            trailing: Text('${totalCarbohydrates}g'),
                          ),
                          ListTile(
                            title: const Text('Fat'),
                            trailing: Text('${totalFats}g'),
                          ),
                          ListTile(
                            title: const Text('Total Calories'),
                            trailing: Text(totalCalories.toString()),
                          ),
                          ...meals.map((meal) => MealDisplay(
                                mealId: meal.id!,
                                mealName: meal.name,
                                mealItems: meal.items,
                              )),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const InputBox(),
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePicker(
      BuildContext context, WidgetRef ref, DateTime selectedDate) {
    DateTime tempPickedDate = selectedDate;
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 310,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        final DateTime today = DateTime.now();
                        ref.read(selectedDateProvider.notifier).update(today);
                        Navigator.pop(context);
                      },
                      child: const Text('Today'),
                    ),
                    TextButton(
                      onPressed: () {
                        ref
                            .read(selectedDateProvider.notifier)
                            .update(tempPickedDate);
                        Navigator.pop(context);
                      },
                      child: const Text('Done'),
                    ),
                  ],
                ),
                Expanded(
                  child: CalendarDatePicker(
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    onDateChanged: (DateTime newDate) {
                      tempPickedDate = newDate;
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
