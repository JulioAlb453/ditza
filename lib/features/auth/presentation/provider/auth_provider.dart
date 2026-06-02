import 'package:flutter/material.dart';
import '../../../../core/shared/enums.dart';
import '../../domain/repository/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  
  ViewState _state = ViewState.initial;
  String? _errorMessage;
  bool _isAuthenticated = false;

  AuthProvider({required this.authRepository});

  ViewState get state => _state;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _isAuthenticated;

  bool get isLoading => _state == ViewState.loading;

  Future<bool> login(String email, String password) async {
    _state = ViewState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await authRepository.login(email, password);
      _isAuthenticated = true;
      _state = ViewState.loaded;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isAuthenticated = false;
      _state = ViewState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String alias, String email, String password) async {
    _state = ViewState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await authRepository.register(alias, email, password);
      _state = ViewState.loaded;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _state = ViewState.error;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await authRepository.logout();
    _isAuthenticated = false;
    _state = ViewState.initial;
    notifyListeners();
  }
}
