import 'package:flutter/material.dart';
import '../../domain/entity/habit.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;
  final VoidCallback? onComplete;

  const HabitCard({
    super.key,
    required this.habit,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isCompletedToday = habit.lastCompleteDate != null &&
        habit.lastCompleteDate!.day == DateTime.now().day &&
        habit.lastCompleteDate!.month == DateTime.now().month &&
        habit.lastCompleteDate!.year == DateTime.now().year;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.05),
            offset: const Offset(8, 8),
            blurRadius: 16,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.9),
            offset: const Offset(-8, -8),
            blurRadius: 16,
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onComplete,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.surface,
                boxShadow: isCompletedToday
                    ? []
                    : [
                        BoxShadow(
                          color: colorScheme.shadow.withOpacity(0.1),
                          offset: const Offset(3, 3),
                          blurRadius: 6,
                        ),
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(-3, -3),
                          blurRadius: 6,
                        ),
                      ],
              ),
              child: isCompletedToday
                  ? Icon(Icons.check_circle, color: colorScheme.primary, size: 36)
                  : Icon(Icons.circle_outlined,
                      color: colorScheme.outline.withOpacity(0.3), size: 36),
            ),
          ),
          const SizedBox(width: 16),
          // Habit Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  habit.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface.withOpacity(0.8),
                      ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'Diaria',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant.withOpacity(0.6),
                          ),
                    ),
                    const SizedBox(width: 8),
                    const Text('🔥', style: TextStyle(fontSize: 12)),
                    const SizedBox(width: 4),
                    Text(
                      '${habit.currentStreak}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary.withOpacity(0.7),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.close,
              color: colorScheme.onSurface.withOpacity(0.1), size: 18),
        ],
      ),
    );
  }
}
