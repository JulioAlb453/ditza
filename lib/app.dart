import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/shared/theme.dart';
import 'core/shared/util.dart';
import 'core/navigation/app_routes.dart';
import 'core/network/api_client.dart';
import 'core/network/auth_api_client.dart';
import 'core/shared/shared_prefs_service.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/presentation/provider/auth_provider.dart';
import 'features/habits/data/repositories/HabitRepositoryImpl.dart';
import 'features/habits/domain/repository/HabitRepository.dart';
import 'features/habits/domain/usecases/create_habit.dart';
import 'features/habits/domain/usecases/get_habits.dart';
import 'features/habits/domain/usecases/delete_habit.dart';
import 'features/habits/presentation/provider/habitProvider.dart';

class Ditza extends StatelessWidget {
  final SharedPreferences sharedPrefs;

  const Ditza({super.key, required this.sharedPrefs});

  @override
  Widget build(BuildContext context) {
    const bodyFont = 'Montserrat';
    const displayFont = 'Montserrat';

    final textTheme = createTextTheme(context, bodyFont, displayFont);
    final materialTheme = MaterialTheme(textTheme);

    return MultiProvider(
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
        Provider(
          create: (context) => DeleteHabit(context.read<HabitRepository>()),
        ),

        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => HabitProvider(
            getHabits: context.read<GetHabits>(),
            createHabit: context.read<CreateHabit>(),
            deleteHabit: context.read<DeleteHabit>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Ditza',
        debugShowCheckedModeBanner: false,
        theme: materialTheme.light(),
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
