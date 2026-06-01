import 'package:ditza/features/habits/domain/entity/habit.dart';
import 'package:ditza/features/habits/domain/usecases/create_habit.dart';
import 'package:ditza/features/habits/domain/usecases/get_habits.dart';
import 'package:flutter/material.dart';

class HabitProvider with ChangeNotifier {
  final GetHabits getHabits;
  final CreateHabit createHabit;

  List<Habit> _habits = [];
  bool _isLoading = false;
  String? _errorMessage;

  HabitProvider({
    required this.getHabits,
    required this.createHabit,
  });

  List<Habit> get habits => _habits;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchHabits() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _habits = await getHabits();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> registerHabit(String title) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newHabit = await createHabit(title);
      _habits.add(newHabit);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
