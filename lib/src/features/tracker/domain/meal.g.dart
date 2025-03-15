// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MealImpl _$$MealImplFromJson(Map<String, dynamic> json) => _$MealImpl(
      id: (json['meal_id'] as num?)?.toInt(),
      name: json['meal_name'] as String,
      date: DateTime.parse(json['meal_date'] as String),
      items: (json['meal_items'] as List<dynamic>?)
              ?.map((e) => MealItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$MealImplToJson(_$MealImpl instance) =>
    <String, dynamic>{
      'meal_id': instance.id,
      'meal_name': instance.name,
      'meal_date': instance.date.toIso8601String(),
      'meal_items': instance.items,
    };
