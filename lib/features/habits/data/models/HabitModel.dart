import '../../domain/entity/habit.dart';

class HabitModel extends Habit {
  HabitModel({
    required super.id,
    required super.title,
    super.description,
    super.emoji,
    super.category,
    super.color,
    super.frequency,
    super.targetCount,
    super.targetUnit,
    super.difficulty,
    super.reminderTime,
    required super.isActive,
    required super.currentStreak,
    required super.bestStreak,
    super.lastCompleteDate,
  });

  factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
      id: json['habit_id']?.toString() ?? json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String?,
      emoji: json['emoji'] as String?,
      category: json['category'] as String?,
      color: json['color'] as String?,
      frequency: json['frequency'] as String?,
      targetCount: json['target_count'] as int?,
      targetUnit: json['target_unit'] as String?,
      difficulty: json['difficulty'] as String?,
      reminderTime: json['reminder_time'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      currentStreak: json['current_streak'] as int? ?? 0,
      bestStreak: json['best_streak'] as int? ?? 0,
      lastCompleteDate: json['last_completed_date'] != null
          ? DateTime.tryParse(json['last_completed_date'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'emoji': emoji,
      'category': category,
      'color': color,
      'frequency': frequency,
      'target_count': targetCount,
      'target_unit': targetUnit,
      'difficulty': difficulty,
      'reminder_time': reminderTime,
    };
  }
}
