import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:macro_ai/src/features/tracker/domain/food.dart';

part 'meal_item.freezed.dart';
part 'meal_item.g.dart';

@freezed
class MealItem with _$MealItem {
  const factory MealItem({
    @JsonKey(name: 'meal_item_id') int? id,
    required double servings,
    required Food food,
  }) = _MealItem;
  factory MealItem.fromJson(Map<String, Object?> json) =>
      _$MealItemFromJson(json);
}
