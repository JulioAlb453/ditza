import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/shared/enums.dart';
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
      appBar: AppBar(
        title: Text(
          'Mis Hábitos',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateHabitDialog(context),
        label: const Text('Nuevo Hábito'),
        icon: const Icon(Icons.add),
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
      ),
      body: SafeArea(
        child: _buildBody(habitProvider, colorScheme),
      ),
    );
  }

  Widget _buildBody(HabitProvider provider, ColorScheme colorScheme) {
    switch (provider.state) {
      case ViewState.initial:
      case ViewState.loading:
        return const Center(child: CircularProgressIndicator());
      case ViewState.error:
        return Center(child: Text(provider.errorMessage ?? 'Error desconocido'));
      case ViewState.loaded:
        if (provider.habits.isEmpty) {
          return Center(
            child: Text(
              'Aún no tienes hábitos.\n¡Crea uno nuevo!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: _buildSummaryCard(context, colorScheme),
              ),
            ),
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
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        );
    }
  }

  Widget _buildSummaryCard(BuildContext context, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(context, 'Total', '5', Icons.list_alt, colorScheme),
          _buildStatItem(
              context, 'Hoy', '3', Icons.check_circle_outline, colorScheme),
          _buildStatItem(context, 'Racha', '12', Icons.bolt, colorScheme),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value,
      IconData icon, ColorScheme colorScheme) {
    return Column(
      children: [
        Icon(icon, color: colorScheme.onTertiaryContainer),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onTertiaryContainer,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: colorScheme.onTertiaryContainer.withOpacity(0.7),
              ),
        ),
      ],
    );
  }

  void _showCreateHabitDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
                context.read<HabitProvider>().registerHabit(controller.text);
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
