import '../../domain/entity/habit.dart';

class HabitModel extends Habit {
  HabitModel({
    required super.id,
    required super.title,
    required super.isActive,
    required super.currentStreak,
    required super.bestStreak,
    super.lastCompleteDate,
  });

  factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
      id: json['habit_id'] as String,
      title: json['title'] as String,
      isActive: json['is_active'] as bool? ?? true,
      currentStreak: json['current_streak'] as int? ?? 0,
      bestStreak: json['best_streak'] as int? ?? 0,
      lastCompleteDate: json['last_completed_date'] != null
          ? DateTime.parse(json['last_completed_date'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
    };
  }
}
