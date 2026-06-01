class Habit {
  final String id;
  final String title;
  final bool isActive;
  final int currentStreak;
  final int bestStreak;
  final DateTime? lastCompleteDate;

   Habit({
     required this.id,
     required this.title,
     required this.isActive,
     required this.currentStreak,
     required this.bestStreak,
     this.lastCompleteDate
   });


}