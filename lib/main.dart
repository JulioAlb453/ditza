import 'package:device_preview/device_preview.dart';
import 'package:ditza/app.dart';
import 'package:ditza/core/network/api_client.dart';
import 'package:ditza/features/habits/data/repositories/HabitRepositoryImpl.dart';
import 'package:ditza/features/habits/domain/repository/HabitRepository.dart';
import 'package:ditza/features/habits/domain/usecases/create_habit.dart';
import 'package:ditza/features/habits/domain/usecases/get_habits.dart';
import 'package:ditza/features/habits/presentation/provider/habitProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // Configuración de dependencias manual
  final apiClient = ApiClient(baseUrl: 'http://10.0.2.2:8080');
  final habitRepository = HabitRepositoryImpl(api: apiClient);
  
  // Casos de uso
  final getHabits = GetHabits(habitRepository);
  final createHabit = CreateHabit(habitRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HabitProvider(
            getHabits: getHabits,
            createHabit: createHabit,
          ),
        ),
      ],
      child: DevicePreview(
        enabled: kIsWeb,
        builder: (context) => const MyApp(),
      ),
    ),
  );
}

