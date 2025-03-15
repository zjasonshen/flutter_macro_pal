import 'package:freezed_annotation/freezed_annotation.dart';

part 'food.freezed.dart';
part 'food.g.dart';

@freezed
class Food with _$Food {
  const factory Food({
    @JsonKey(name: 'food_id') int? id,
    required String name,
    required int calories,
    required int protein,
    required int carbohydrates,
    required int fat,
    @JsonKey(name: 'serving_size') required String servingSize,
  }) = _Food;
  const Food._();

  factory Food.fromJson(Map<String, Object?> json) => _$FoodFromJson(json);
}
