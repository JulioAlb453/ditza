import 'package:ditza/features/habits/domain/entity/habit.dart';
import 'package:ditza/features/habits/domain/usecases/create_habit.dart';
import 'package:ditza/features/habits/domain/usecases/get_habits.dart';
import 'package:flutter/material.dart';
import '../../../../core/shared/enums.dart';

class HabitProvider with ChangeNotifier {
  final GetHabits getHabits;
  final CreateHabit createHabit;

  List<Habit> _habits = [];
  ViewState _state = ViewState.initial;
  String? _errorMessage;

  HabitProvider({
    required this.getHabits,
    required this.createHabit,
  });

  List<Habit> get habits => _habits;
  ViewState get state => _state;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _state == ViewState.loading;

  Future<void> fetchHabits() async {
    _state = ViewState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _habits = await getHabits();
      _state = ViewState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ViewState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> registerHabit(String title) async {
    _state = ViewState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final newHabit = await createHabit(title);
      _habits.add(newHabit);
      _state = ViewState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ViewState.error;
    } finally {
      notifyListeners();
    }
  }
}
