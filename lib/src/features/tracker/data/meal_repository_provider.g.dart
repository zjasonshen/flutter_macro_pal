// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mealRepositoryHash() => r'236ff85f047aab3d9349742f0a5eaf0285435324';

/// See also [mealRepository].
@ProviderFor(mealRepository)
final mealRepositoryProvider = AutoDisposeProvider<MealRepository>.internal(
  mealRepository,
  name: r'mealRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mealRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MealRepositoryRef = AutoDisposeProviderRef<MealRepository>;
String _$mealsHash() => r'3171d016b0e7a65eb4384a56cfafec251772b67e';

/// See also [meals].
@ProviderFor(meals)
final mealsProvider = AutoDisposeFutureProvider<List<Meal>>.internal(
  meals,
  name: r'mealsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$mealsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MealsRef = AutoDisposeFutureProviderRef<List<Meal>>;
String _$deleteMealHash() => r'1c0e425a48192545b58cada37164da9a74346b4b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [deleteMeal].
@ProviderFor(deleteMeal)
const deleteMealProvider = DeleteMealFamily();

/// See also [deleteMeal].
class DeleteMealFamily extends Family<AsyncValue<bool>> {
  /// See also [deleteMeal].
  const DeleteMealFamily();

  /// See also [deleteMeal].
  DeleteMealProvider call(
    int mealId,
  ) {
    return DeleteMealProvider(
      mealId,
    );
  }

  @override
  DeleteMealProvider getProviderOverride(
    covariant DeleteMealProvider provider,
  ) {
    return call(
      provider.mealId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'deleteMealProvider';
}

/// See also [deleteMeal].
class DeleteMealProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [deleteMeal].
  DeleteMealProvider(
    int mealId,
  ) : this._internal(
          (ref) => deleteMeal(
            ref as DeleteMealRef,
            mealId,
          ),
          from: deleteMealProvider,
          name: r'deleteMealProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteMealHash,
          dependencies: DeleteMealFamily._dependencies,
          allTransitiveDependencies:
              DeleteMealFamily._allTransitiveDependencies,
          mealId: mealId,
        );

  DeleteMealProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mealId,
  }) : super.internal();

  final int mealId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(DeleteMealRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteMealProvider._internal(
        (ref) => create(ref as DeleteMealRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mealId: mealId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _DeleteMealProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteMealProvider && other.mealId == mealId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mealId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DeleteMealRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `mealId` of this provider.
  int get mealId;
}

class _DeleteMealProviderElement extends AutoDisposeFutureProviderElement<bool>
    with DeleteMealRef {
  _DeleteMealProviderElement(super.provider);

  @override
  int get mealId => (origin as DeleteMealProvider).mealId;
}

String _$editMealItemHash() => r'fc81f237ae702a9e6e51ff42120e3a23357883ba';

/// See also [editMealItem].
@ProviderFor(editMealItem)
const editMealItemProvider = EditMealItemFamily();

/// See also [editMealItem].
class EditMealItemFamily extends Family<AsyncValue<bool>> {
  /// See also [editMealItem].
  const EditMealItemFamily();

  /// See also [editMealItem].
  EditMealItemProvider call(
    MealItem updatedData,
  ) {
    return EditMealItemProvider(
      updatedData,
    );
  }

  @override
  EditMealItemProvider getProviderOverride(
    covariant EditMealItemProvider provider,
  ) {
    return call(
      provider.updatedData,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'editMealItemProvider';
}

/// See also [editMealItem].
class EditMealItemProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [editMealItem].
  EditMealItemProvider(
    MealItem updatedData,
  ) : this._internal(
          (ref) => editMealItem(
            ref as EditMealItemRef,
            updatedData,
          ),
          from: editMealItemProvider,
          name: r'editMealItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editMealItemHash,
          dependencies: EditMealItemFamily._dependencies,
          allTransitiveDependencies:
              EditMealItemFamily._allTransitiveDependencies,
          updatedData: updatedData,
        );

  EditMealItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.updatedData,
  }) : super.internal();

  final MealItem updatedData;

  @override
  Override overrideWith(
    FutureOr<bool> Function(EditMealItemRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EditMealItemProvider._internal(
        (ref) => create(ref as EditMealItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        updatedData: updatedData,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _EditMealItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditMealItemProvider && other.updatedData == updatedData;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, updatedData.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EditMealItemRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `updatedData` of this provider.
  MealItem get updatedData;
}

class _EditMealItemProviderElement
    extends AutoDisposeFutureProviderElement<bool> with EditMealItemRef {
  _EditMealItemProviderElement(super.provider);

  @override
  MealItem get updatedData => (origin as EditMealItemProvider).updatedData;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
