import 'dart:io';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:macro_ai/src/features/authentication/application/auth_service.dart';
import 'package:macro_ai/src/features/backend/data/dio_provider.dart';
import 'package:macro_ai/src/features/tracker/data/image_input_file_provider.dart';
import 'package:macro_ai/src/features/tracker/data/meal_repository_provider.dart';
import 'package:macro_ai/src/features/tracker/data/selected_date_provider.dart';
import 'package:macro_ai/src/features/tracker/data/transcribed_text_provider.dart';
import 'package:macro_ai/src/features/tracker/domain/meal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http_parser/http_parser.dart';

part 'backend_service.g.dart';

@riverpod
class BackendService extends _$BackendService {
  late final Dio _dio;
  String? token;

  @override
  BackendService build() {
    _dio = ref.read(dioProvider);
    token = ref.watch(authServiceProvider);
    return this;
  }

  Future<Meal?> submitInput() async {
    // DateTime mealDate, String transcribedText, XFile image) async {
    final mealDate = ref.read(selectedDateProvider);
    final image = ref.read(imageInputFileProvider);
    final text = ref.read(transcribedTextProvider);
    Map<String, dynamic> data = {};
    try {
      if (image != null) {
        data['image'] = MultipartFileRecreatable.fromFileSync(
          image.path,
          contentType: MediaType('image', 'jpeg'),
        );
      } else {
        data['image'] = '';
      }
      data['meal_date'] = DateFormat('yyyy-MM-dd').format(mealDate);
      data['text'] = text;
      final formData = FormData.fromMap(data);
      final response = await _dio.post(
        '/submitInput',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        ref.read(transcribedTextProvider.notifier).clearText();
        ref.read(imageInputFileProvider.notifier).clearImage();
        ref.invalidate(mealsProvider);
        return Meal.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String> uploadAudio(File file) async {
    try {
      final formData = FormData.fromMap({
        'file': MultipartFileRecreatable.fromFileSync(
          file.path,
          contentType: DioMediaType("audio", "mp4"),
        )
      });
      final response = await _dio.post(
        '/audio',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return response.data["data"] as String;
      } else {
        return 'Try Again';
      }
    } catch (e) {
      // print(e);
      return 'Try Again';
    }
  }

  Future<Meal?> processText(DateTime mealDate, String transcribedText) async {
    try {
      final jsonData = {
        'meal_date': DateFormat('yyyy-MM-dd').format(mealDate),
        'text': transcribedText,
      };
      final response = await _dio.post(
        '/processText',
        data: jsonData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      ref.read(transcribedTextProvider.notifier).clearText();
      ref.invalidate(mealsProvider);
      return Meal.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }
}
