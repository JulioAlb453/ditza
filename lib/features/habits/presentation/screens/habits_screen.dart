import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/shared/widgets/app_error_widget.dart';
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
        return Center(
          child: AppErrorWidget(
            message: provider.errorMessage ?? 'Error desconocido',
            onRetry: () => provider.fetchHabits(),
          ),
        );
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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    String selectedColor = 'pink';
    String selectedCategory = 'Salud';
    String selectedFrequency = 'Diaria';
    String selectedDifficulty = 'Medio';
    String selectedUnit = 'min';
    TimeOfDay selectedTime = const TimeOfDay(hour: 9, minute: 0);

    final titleController = TextEditingController();
    final descController = TextEditingController();
    final targetCountController = TextEditingController();

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, anim1, anim2) => const SizedBox(),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: ScaleTransition(
            scale: anim1,
            child: StatefulBuilder(
              builder: (context, setModalState) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nuevo Hábito',
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: colorScheme.onSurface.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 24),

                          _buildInputLabel('Título'),
                          _buildNeumorphicField(
                            controller: titleController,
                            hint: 'Ej: Ejercicio matutino',
                          ),
                          const SizedBox(height: 20),

                          _buildInputLabel('Descripción'),
                          _buildNeumorphicField(
                            controller: descController,
                            hint: '¿Por qué es importante este hábito?',
                            maxLines: 3,
                          ),
                          const SizedBox(height: 24),

                          _buildInputLabel('Categoría'),
                          _buildNeumorphicDropdown(
                            value: selectedCategory,
                            items: ['Salud', 'Estudio', 'Finanzas', 'Ocio', 'Social'],
                            onChanged: (val) => setModalState(() => selectedCategory = val!),
                            colorScheme: colorScheme,
                          ),
                          const SizedBox(height: 24),

                          _buildInputLabel('Color'),
                          _buildColorGrid(
                            selectedColor,
                            (color) => setModalState(() => selectedColor = color),
                            colorScheme,
                          ),
                          const SizedBox(height: 24),

                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInputLabel('Frecuencia'),
                                    _buildNeumorphicDropdown(
                                      value: selectedFrequency,
                                      items: ['Diaria', 'Semanal', 'Mensual'],
                                      onChanged: (val) => setModalState(() => selectedFrequency = val!),
                                      colorScheme: colorScheme,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInputLabel('Meta (Nº)'),
                                    _buildNeumorphicField(
                                      controller: targetCountController,
                                      hint: 'Ej: 30',
                                      isNumber: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInputLabel('Unidad'),
                                    _buildNeumorphicDropdown(
                                      value: selectedUnit,
                                      items: ['min', 'páginas', 'L', 'km', 'veces'],
                                      onChanged: (val) => setModalState(() => selectedUnit = val!),
                                      colorScheme: colorScheme,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInputLabel('Dificultad'),
                                    _buildNeumorphicDropdown(
                                      value: selectedDifficulty,
                                      items: ['Fácil', 'Medio', 'Difícil'],
                                      onChanged: (val) => setModalState(() => selectedDifficulty = val!),
                                      colorScheme: colorScheme,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          _buildInputLabel('Recordatorio'),
                          _buildNeumorphicTimePicker(
                            context: context,
                            time: selectedTime,
                            onTap: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime: selectedTime,
                              );
                              if (picked != null) {
                                setModalState(() => selectedTime = picked);
                              }
                            },
                            colorScheme: colorScheme,
                          ),
                          const SizedBox(height: 32),

                          Row(
                            children: [
                              Expanded(
                                child: _buildActionButton(
                                  label: 'Cancelar',
                                  onTap: () => Navigator.pop(context),
                                  colorScheme: colorScheme,
                                  isPrimary: false,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildActionButton(
                                  label: 'Crear',
                                  onTap: () async {
                                    final title = titleController.text.trim();
                                    final description = descController.text.trim();
                                    final targetCountText = targetCountController.text.trim();
                                    final targetCount = int.tryParse(targetCountText) ?? 1;

                                    if (title.isNotEmpty) {
                                      final habitData = {
                                        'title': title,
                                        'description': description,
                                        'category': selectedCategory.toLowerCase(),
                                        'color': selectedColor,
                                        'frequency': selectedFrequency == 'Diaria' ? 'daily' : 'weekly',
                                        'target_count': targetCount,
                                        'target_unit': selectedUnit.trim(),
                                        'difficulty': selectedDifficulty == 'Medio' ? 'medium' : 'easy',
                                        'reminder_time': '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}',
                                      };
                                      
                                      try {
                                        await context.read<HabitProvider>().registerHabit(habitData);
                                        if (mounted) Navigator.pop(context);
                                      } catch (e) {
                                        if (mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.transparent,
                                              elevation: 0,
                                              content: AppErrorWidget(
                                                message: e.toString().replaceAll('Exception: ', ''),
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    }
                                  },
                                  colorScheme: colorScheme,
                                  isPrimary: true,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.6),
            ),
      ),
    );
  }

  Widget _buildNeumorphicField({
    required TextEditingController controller,
    required String hint,
    bool isNumber = false,
    int maxLines = 1,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.05),
            offset: const Offset(4, 4),
            blurRadius: 8,
            spreadRadius: -2,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-4, -4),
            blurRadius: 8,
            spreadRadius: -2,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.2)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildNeumorphicDropdown({
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
    required ColorScheme colorScheme,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.05),
            offset: const Offset(4, 4),
            blurRadius: 8,
            spreadRadius: -2,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-4, -4),
            blurRadius: 8,
            spreadRadius: -2,
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          style: Theme.of(context).textTheme.bodyLarge,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildColorGrid(String selected, void Function(String) onSelected, ColorScheme colorScheme) {
    final colorsMap = {
      'pink': colorScheme.primary,
      'lightPink': colorScheme.primaryContainer,
      'orange': const Color(0xFFFF9800),
      'blue': const Color(0xFF2196F3),
      'green': const Color(0xFF4CAF50),
      'purple': const Color(0xFF9C27B0),
    };

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: colorsMap.entries.map((e) {
        final isSelected = e.key == selected;
        return GestureDetector(
          onTap: () => onSelected(e.key),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: e.value,
              borderRadius: BorderRadius.circular(16),
              border: isSelected ? Border.all(color: colorScheme.onSurface, width: 2) : null,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.1),
                  offset: const Offset(4, 4),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNeumorphicTimePicker({
    required BuildContext context,
    required TimeOfDay time,
    required VoidCallback onTap,
    required ColorScheme colorScheme,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.05),
              offset: const Offset(4, 4),
              blurRadius: 8,
              spreadRadius: -2,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 8,
              spreadRadius: -2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(time.format(context), style: Theme.of(context).textTheme.bodyLarge),
            Icon(Icons.access_time, color: colorScheme.onSurface.withOpacity(0.4), size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required VoidCallback onTap,
    required ColorScheme colorScheme,
    required bool isPrimary,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.05),
              offset: const Offset(6, 6),
              blurRadius: 12,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-6, -6),
              blurRadius: 12,
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isPrimary ? colorScheme.primary : colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}
