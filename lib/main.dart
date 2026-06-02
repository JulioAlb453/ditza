import 'package:device_preview/device_preview.dart';
import 'package:ditza/app.dart';
import 'package:ditza/core/auth/auth_service.dart';
import 'package:ditza/core/network/api_client.dart';
import 'package:ditza/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ditza/features/auth/presentation/provider/auth_provider.dart';
import 'package:ditza/features/habits/data/repositories/HabitRepositoryImpl.dart';
import 'package:ditza/features/habits/domain/usecases/create_habit.dart';
import 'package:ditza/features/habits/domain/usecases/get_habits.dart';
import 'package:ditza/features/habits/presentation/provider/habitProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authService = AuthService();
  
  const baseUrl = 'http://34.201.68.191:8080';
  
  final apiClient = ApiClient(
    baseUrl: baseUrl,
    authService: authService,
  );

  final authRepository = AuthRepositoryImpl(api: apiClient, authService: authService);
  final habitRepository = HabitRepositoryImpl(api: apiClient);

  final getHabits = GetHabits(habitRepository);
  final createHabit = CreateHabit(habitRepository);

  final hasToken = await authService.hasToken();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(authRepository: authRepository),
        ),
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
