import 'package:flutter/material.dart';
import '../../domain/repository/auth_repository.dart';

enum AuthState { initial, loading, loaded, error }

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  
  AuthState _state = AuthState.initial;
  String? _errorMessage;
  bool _isAuthenticated = false;

  AuthProvider({required this.authRepository});

  AuthState get state => _state;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _isAuthenticated;

  bool get isLoading => _state == AuthState.loading;

  Future<bool> login(String email, String password) async {
    _state = AuthState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await authRepository.login(email, password);
      _isAuthenticated = true;
      _state = AuthState.loaded;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isAuthenticated = false;
      _state = AuthState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String alias, String email, String password) async {
    _state = AuthState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await authRepository.register(alias, email, password);
      _state = AuthState.loaded;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _state = AuthState.error;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await authRepository.logout();
    _isAuthenticated = false;
    _state = AuthState.initial;
    notifyListeners();
  }
}
