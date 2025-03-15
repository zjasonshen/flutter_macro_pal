// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MealItemImpl _$$MealItemImplFromJson(Map<String, dynamic> json) =>
    _$MealItemImpl(
      id: (json['meal_item_id'] as num?)?.toInt(),
      servings: (json['servings'] as num).toDouble(),
      food: Food.fromJson(json['food'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MealItemImplToJson(_$MealItemImpl instance) =>
    <String, dynamic>{
      'meal_item_id': instance.id,
      'servings': instance.servings,
      'food': instance.food,
    };
