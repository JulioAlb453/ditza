import 'package:ditza/features/habits/domain/entity/habit.dart';
import 'package:ditza/features/habits/domain/usecases/create_habit.dart';
import 'package:ditza/features/habits/domain/usecases/get_habits.dart';
import 'package:flutter/material.dart';

enum HabitState { initial, loading, loaded, error }

class HabitProvider with ChangeNotifier {
  final GetHabits getHabits;
  final CreateHabit createHabit;

  List<Habit> _habits = [];
  HabitState _state = HabitState.initial;
  String? _errorMessage;
  
  int get totalHabits => _habits.length;
  int get completedToday => _habits.where((h) {
    if (h.lastCompleteDate == null) return false;
    final now = DateTime.now();
    return h.lastCompleteDate!.year == now.year &&
        h.lastCompleteDate!.month == now.month &&
        h.lastCompleteDate!.day == now.day;
  }).length;

  int get maxStreak => _habits.isEmpty
      ? 0
      : _habits
      .map((h) => h.currentStreak)
      .reduce((a, b) => a > b ? a : b);

  HabitProvider({
    required this.getHabits,
    required this.createHabit,
  });

  List<Habit> get habits => _habits;
  HabitState get state => _state;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _state == HabitState.loading;

  Future<void> fetchHabits() async {
    _state = HabitState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _habits = await getHabits();
      _state = HabitState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = HabitState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> registerHabit(Map<String, dynamic> habitData) async {
    _state = HabitState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final newHabit = await createHabit(habitData);
      _habits.add(newHabit);
      _state = HabitState.loaded;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _state = HabitState.error;
      rethrow; 
    } finally {
      notifyListeners();
    }
  }
}
