import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:macro_ai/src/features/tracker/domain/meal_item.dart';

part 'meal.freezed.dart';
part 'meal.g.dart';

@freezed
class Meal with _$Meal {
  const Meal._();

  const factory Meal({
    @JsonKey(name: 'meal_id') required int? id,
    @JsonKey(name: 'meal_name') required String name,
    @JsonKey(name: 'meal_date') required DateTime date,
    @JsonKey(name: 'meal_items') @Default([]) List<MealItem> items,
  }) = _Meal;
  factory Meal.fromJson(Map<String, Object?> json) => _$MealFromJson(json);

  int get totalCalories => items
      .map((item) => item.food.calories * item.servings)
      .reduce((a, b) => a + b)
      .toInt();

  int get totalProtein => items
      .map((item) => item.food.protein * item.servings)
      .reduce((a, b) => a + b)
      .toInt();

  int get totalCarbohydrates => items
      .map((item) => item.food.carbohydrates * item.servings)
      .reduce((a, b) => a + b)
      .toInt();

  int get totalFat => items
      .map((item) => item.food.fat * item.servings)
      .reduce((a, b) => a + b)
      .toInt();
}
