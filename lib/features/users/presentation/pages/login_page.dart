import 'package:ditza/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/navigation/app_routes.dart';
import '../widgets/auth_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainer,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              AuthContainer(
                borderRadius: 50,
                padding: const EdgeInsets.all(20),
                child: Icon(
                  Icons.auto_awesome,
                  size: 60,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Bienvenido a Ditza',
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Inicia sesión para continuar',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 50),
              
              _buildTextField(
                controller: _emailController,
                label: 'Correo Electrónico',
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 25),
              
              _buildTextField(
                controller: _passwordController,
                label: 'Contraseña',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 40),
              
              GestureDetector(
                onTapDown: (_) => setState(() => _isButtonPressed = true),
                onTapUp:   (_) => setState(() => _isButtonPressed = false),
                onTapCancel: () => setState(() => _isButtonPressed = false),
                onTap: () async {
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();

                  if (email.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Por favor, completa todos los campos')),
                    );
                    return;
                  }

                  final success = await context.read<AuthProvider>().login(email, password);

                  if (mounted) {
                    if (success) {
                      Navigator.pushReplacementNamed(context, AppRoutes.habits);
                    } else {
                      final error = context.read<AuthProvider>().errorMessage;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error ?? 'Error al iniciar sesión')),
                      );
                    }
                  }
                },
                child: AuthContainer(
                  isPressed: _isButtonPressed,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Center(
                    child: context.watch<AuthProvider>().isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            'Entrar',
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¿No tienes cuenta? ',
                    style: textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.register);
                    },
                    child: Text(
                      'Regístrate',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        AuthContainer(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          borderRadius: 15,
          isPressed: true,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(icon, color: colorScheme.primary.withOpacity(0.7)),
            ),
          ),
        ),
      ],
    );
  }
}
