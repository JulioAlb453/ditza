import 'package:device_preview/device_preview.dart';
import 'package:ditza/app.dart';
import 'package:ditza/core/network/api_client.dart';
import 'package:ditza/core/network/auth_api_client.dart';
import 'package:ditza/core/shared/shared_prefs_service.dart';
import 'package:ditza/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ditza/features/auth/domain/repository/auth_repository.dart';
import 'package:ditza/features/auth/presentation/provider/auth_provider.dart';
import 'package:ditza/features/habits/data/repositories/HabitRepositoryImpl.dart';
import 'package:ditza/features/habits/domain/repository/HabitRepository.dart';
import 'package:ditza/features/habits/domain/usecases/create_habit.dart';
import 'package:ditza/features/habits/domain/usecases/get_habits.dart';
import 'package:ditza/features/habits/presentation/provider/habitProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => SharedPreferencesService(sharedPrefs)),
        Provider(create: (context) => ApiClient()),
        Provider(
          create: (context) => AuthApiClient(
            context.read<SharedPreferencesService>(),
          ),
        ),

        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            api: context.read<ApiClient>(),
            authService: context.read<SharedPreferencesService>(),
          ),
        ),
        Provider<HabitRepository>(
          create: (context) => HabitRepositoryImpl(
            api: context.read<AuthApiClient>(),
          ),
        ),

        Provider(
          create: (context) => GetHabits(context.read<HabitRepository>()),
        ),
        Provider(
          create: (context) => CreateHabit(context.read<HabitRepository>()),
        ),

        // Providers (ViewModels)
        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => HabitProvider(
            getHabits: context.read<GetHabits>(),
            createHabit: context.read<CreateHabit>(),
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
