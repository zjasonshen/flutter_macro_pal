import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:macro_ai/src/features/authentication/application/auth_service.dart';
import 'package:macro_ai/src/features/backend/data/dio_provider.dart';
import 'package:macro_ai/src/features/tracker/data/selected_date_provider.dart';
import 'package:macro_ai/src/features/tracker/domain/meal_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:macro_ai/src/features/tracker/domain/meal.dart';

part 'meal_repository_provider.g.dart';

class MealRepository {
  final Dio dio;
  final String apiUrl;

  MealRepository({required this.dio, required this.apiUrl});

  Future<List<Meal>> _fetchMeals(String clientToken, DateTime date) async {
    try {
      final response = await dio.get(apiUrl,
          queryParameters: {"date": DateFormat('yyyy-MM-dd').format(date)},
          options: Options(
            headers: {
              'Authorization': 'Bearer $clientToken',
            },
          ));

      if (response.statusCode == 200) {
        List<dynamic> data = response.data["data"];
        return data.map((meal) => Meal.fromJson(meal)).toList();
      } else {
        throw Exception('Failed to load meals');
      }
    } catch (error) {
      throw Exception('Failed to load meals: $error');
    }
  }

  Future<bool> _deleteMeal(String clientToken, int mealId) async {
    // Future<void> updateMeal(Meal updatedMeal) async {}
    try {
      final response = await dio.delete('$apiUrl/$mealId',
          options: Options(
            headers: {
              'Authorization': 'Bearer $clientToken',
            },
          ));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw Exception('Failed to delete meal: $error');
    }
  }

  Future<bool> _editMealItem(String clientToken, MealItem updatedData) async {
    try {
      final response = await dio.put(
        '/meal-item',
        data: updatedData.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $clientToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        return true; // Update was successful
      } else {
        return false; // Update failed with an unexpected status code
      }
    } catch (error) {
      throw Exception('Failed to edit meal item: $error');
    }
  }
}

@riverpod
MealRepository mealRepository(MealRepositoryRef ref) {
  final dioInstance = ref.watch(dioProvider);
  return MealRepository(dio: dioInstance, apiUrl: '/meals');
}

@riverpod
Future<List<Meal>> meals(MealsRef ref) async {
  final repository = ref.watch(mealRepositoryProvider);
  final clientToken = ref.watch(authServiceProvider);
  final date = ref.watch(selectedDateProvider);
  if (clientToken == null) {
    throw AuthenticationException('User is not authenticated');
  }
  return repository._fetchMeals(clientToken, date);
}

@riverpod
Future<bool> deleteMeal(DeleteMealRef ref, int mealId) async {
  final repository = ref.watch(mealRepositoryProvider);
  final clientToken = ref.watch(authServiceProvider);
  if (clientToken == null) {
    throw AuthenticationException('User is not authenticated');
  }
  final resp = await repository._deleteMeal(clientToken, mealId);
  if (resp == true) {
    ref.invalidate(mealsProvider);
  }
  return resp;
}

@riverpod
Future<bool> editMealItem(EditMealItemRef ref, MealItem updatedData) async {
  final repository = ref.watch(mealRepositoryProvider);
  final clientToken = ref.watch(authServiceProvider);
  if (clientToken == null) {
    throw AuthenticationException('User is not authenticated');
  }
  final resp = await repository._editMealItem(clientToken, updatedData);
  if (resp == true) {
    ref.invalidate(mealsProvider);
  }
  return resp;
}
