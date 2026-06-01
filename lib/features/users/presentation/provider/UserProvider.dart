import 'package:flutter/material.dart';
import '../../domain/entity/user.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/create_user.dart';

class UserProvider with ChangeNotifier {
  final GetCurrentUser getCurrentUser;
  final CreateUser createUser;

  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  UserProvider({
    required this.getCurrentUser,
    required this.createUser,
  });

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUser() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await getCurrentUser();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> registerUser() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await createUser();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
