import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/habitProvider.dart';
import '../widgets/habit_card.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HabitProvider>().fetchHabits();
    });
  }

  @override
  Widget build(BuildContext context) {
    final habitProvider = context.watch<HabitProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: _buildBody(habitProvider, colorScheme),
      ),
    );
  }

  Widget _buildBody(HabitProvider provider, ColorScheme colorScheme) {
    switch (provider.state) {
      case HabitState.initial:
      case HabitState.loading:
        return const Center(child: CircularProgressIndicator());
      case HabitState.error:
        return Center(child: Text(provider.errorMessage ?? 'Error desconocido'));
      case HabitState.loaded:
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mis\nHábitos',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: colorScheme.onSurface.withOpacity(0.8),
                            height: 1.1,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Construye mejores hábitos hoy',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant.withOpacity(0.5),
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ),

            // Summary Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: _buildSummaryCard(context, colorScheme),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 30)),

            // Habits List
            if (provider.habits.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Center(
                    child: Text(
                      'Aún no tienes hábitos.\n¡Crea uno nuevo!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final habit = provider.habits[index];
                    return HabitCard(
                      habit: habit,
                      onComplete: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('¡${habit.title} completado!')),
                        );
                      },
                    );
                  },
                  childCount: provider.habits.length,
                ),
              ),

            // Bottom Button
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    _buildCreateButton(context, colorScheme),
                    const SizedBox(height: 20),
                    Text(
                      'Soft Neumorphic Habits Tracker',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant.withOpacity(0.4),
                          ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        );
    }
  }

  Widget _buildSummaryCard(BuildContext context, ColorScheme colorScheme) {
    final provider = context.watch<HabitProvider>();
    final progress = provider.totalHabits > 0 
        ? (provider.completedToday / provider.totalHabits) 
        : 0.0;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.05),
            offset: const Offset(10, 10),
            blurRadius: 20,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.9),
            offset: const Offset(-10, -10),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInnerStatBox(context, 'Totales', provider.totalHabits.toString(), colorScheme),
              _buildInnerStatBox(context, 'Hoy', '', colorScheme, isAccent: true),
              _buildInnerStatBox(context, 'Racha', provider.maxStreak.toString(), colorScheme, hasEmoji: true),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progreso de hoy',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary.withOpacity(0.6),
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: colorScheme.surfaceContainerHighest.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInnerStatBox(BuildContext context, String label, String value, ColorScheme colorScheme, {bool isAccent = false, bool hasEmoji = false}) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.8),
                offset: const Offset(4, 4),
                blurRadius: 8,
              ),
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.1),
                offset: const Offset(-4, -4),
                blurRadius: 8,
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.surfaceContainerHighest.withOpacity(0.3),
                colorScheme.surface,
              ],
            ),
          ),
          child: Center(
            child: isAccent 
              ? Container(
                  width: 40, 
                  height: 24, 
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                )
              : Text(
                  value,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
                ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurfaceVariant.withOpacity(0.5),
                  ),
            ),
            if (hasEmoji) ...[
              const SizedBox(width: 4),
              const Text('🔥', style: TextStyle(fontSize: 10)),
            ]
          ],
        ),
      ],
    );
  }

  Widget _buildCreateButton(BuildContext context, ColorScheme colorScheme) {
    return GestureDetector(
      onTap: () => _showCreateHabitDialog(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: colorScheme.primary.withOpacity(0.1), width: 1),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.05),
              offset: const Offset(6, 6),
              blurRadius: 12,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.9),
              offset: const Offset(-6, -6),
              blurRadius: 12,
            ),
          ],
        ),
        child: Center(
          child: Text(
            '+ Crear Nuevo Hábito',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
          ),
        ),
      ),
    );
  }

  void _showCreateHabitDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Nuevo Hábito'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Ej: Beber 2L de agua',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<HabitProvider>().registerHabit({
                  'title': controller.text,
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Crear'),
          ),
        ],
      ),
    );
  }
}
