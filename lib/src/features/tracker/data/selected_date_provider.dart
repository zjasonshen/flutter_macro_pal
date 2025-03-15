import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_date_provider.g.dart';

@riverpod
class SelectedDate extends _$SelectedDate {
  // Initial date set to today's date.
  @override
  DateTime build() => DateTime.now();

  // Method to update the selected date.
  void update(DateTime newDate) {
    state = newDate;
  }

  void changeDate(int days) {
    state = state.add(Duration(days: days));
  }
}
