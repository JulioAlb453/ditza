class Habit {
  final String id;
  final String title;
  final String? description;
  final String? emoji;
  final String? category;
  final String? color;
  final String? frequency;
  final int? targetCount;
  final String? targetUnit;
  final String? difficulty;
  final String? reminderTime;
  final bool isActive;
  final int currentStreak;
  final int bestStreak;
  final DateTime? lastCompleteDate;

  Habit({
    required this.id,
    required this.title,
    this.description,
    this.emoji,
    this.category,
    this.color,
    this.frequency,
    this.targetCount,
    this.targetUnit,
    this.difficulty,
    this.reminderTime,
    required this.isActive,
    required this.currentStreak,
    required this.bestStreak,
    this.lastCompleteDate,
  });
}
