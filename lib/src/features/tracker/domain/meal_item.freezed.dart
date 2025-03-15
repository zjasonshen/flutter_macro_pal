// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MealItem _$MealItemFromJson(Map<String, dynamic> json) {
  return _MealItem.fromJson(json);
}

/// @nodoc
mixin _$MealItem {
  @JsonKey(name: 'meal_item_id')
  int? get id => throw _privateConstructorUsedError;
  double get servings => throw _privateConstructorUsedError;
  Food get food => throw _privateConstructorUsedError;

  /// Serializes this MealItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealItemCopyWith<MealItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealItemCopyWith<$Res> {
  factory $MealItemCopyWith(MealItem value, $Res Function(MealItem) then) =
      _$MealItemCopyWithImpl<$Res, MealItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'meal_item_id') int? id, double servings, Food food});

  $FoodCopyWith<$Res> get food;
}

/// @nodoc
class _$MealItemCopyWithImpl<$Res, $Val extends MealItem>
    implements $MealItemCopyWith<$Res> {
  _$MealItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? servings = null,
    Object? food = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      servings: null == servings
          ? _value.servings
          : servings // ignore: cast_nullable_to_non_nullable
              as double,
      food: null == food
          ? _value.food
          : food // ignore: cast_nullable_to_non_nullable
              as Food,
    ) as $Val);
  }

  /// Create a copy of MealItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FoodCopyWith<$Res> get food {
    return $FoodCopyWith<$Res>(_value.food, (value) {
      return _then(_value.copyWith(food: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MealItemImplCopyWith<$Res>
    implements $MealItemCopyWith<$Res> {
  factory _$$MealItemImplCopyWith(
          _$MealItemImpl value, $Res Function(_$MealItemImpl) then) =
      __$$MealItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'meal_item_id') int? id, double servings, Food food});

  @override
  $FoodCopyWith<$Res> get food;
}

/// @nodoc
class __$$MealItemImplCopyWithImpl<$Res>
    extends _$MealItemCopyWithImpl<$Res, _$MealItemImpl>
    implements _$$MealItemImplCopyWith<$Res> {
  __$$MealItemImplCopyWithImpl(
      _$MealItemImpl _value, $Res Function(_$MealItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? servings = null,
    Object? food = null,
  }) {
    return _then(_$MealItemImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      servings: null == servings
          ? _value.servings
          : servings // ignore: cast_nullable_to_non_nullable
              as double,
      food: null == food
          ? _value.food
          : food // ignore: cast_nullable_to_non_nullable
              as Food,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealItemImpl implements _MealItem {
  const _$MealItemImpl(
      {@JsonKey(name: 'meal_item_id') this.id,
      required this.servings,
      required this.food});

  factory _$MealItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealItemImplFromJson(json);

  @override
  @JsonKey(name: 'meal_item_id')
  final int? id;
  @override
  final double servings;
  @override
  final Food food;

  @override
  String toString() {
    return 'MealItem(id: $id, servings: $servings, food: $food)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.servings, servings) ||
                other.servings == servings) &&
            (identical(other.food, food) || other.food == food));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, servings, food);

  /// Create a copy of MealItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealItemImplCopyWith<_$MealItemImpl> get copyWith =>
      __$$MealItemImplCopyWithImpl<_$MealItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealItemImplToJson(
      this,
    );
  }
}

abstract class _MealItem implements MealItem {
  const factory _MealItem(
      {@JsonKey(name: 'meal_item_id') final int? id,
      required final double servings,
      required final Food food}) = _$MealItemImpl;

  factory _MealItem.fromJson(Map<String, dynamic> json) =
      _$MealItemImpl.fromJson;

  @override
  @JsonKey(name: 'meal_item_id')
  int? get id;
  @override
  double get servings;
  @override
  Food get food;

  /// Create a copy of MealItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealItemImplCopyWith<_$MealItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
