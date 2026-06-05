import 'package:flutter/material.dart';
import '../../domain/entity/user.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/create_user.dart';

enum UserState { initial, loading, loaded, error }

class UserProvider with ChangeNotifier {
  final GetCurrentUser getCurrentUser;
  final CreateUser createUser;

  User? _user;
  UserState _state = UserState.initial;
  String? _errorMessage;

  UserProvider({
    required this.getCurrentUser,
    required this.createUser,
  });

  User? get user => _user;
  UserState get state => _state;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _state == UserState.loading;

  Future<void> fetchUser() async {
    _state = UserState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await getCurrentUser();
      _state = UserState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = UserState.error;
    }
      notifyListeners();
  }

  Future<void> registerUser() async {
    _state = UserState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await createUser();
      _state = UserState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = UserState.error;
    }
      notifyListeners();
  }
}
