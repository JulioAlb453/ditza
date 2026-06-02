import 'package:flutter/material.dart';
import '../../../../core/shared/enums.dart';
import '../../domain/entity/user.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/create_user.dart';

class UserProvider with ChangeNotifier {
  final GetCurrentUser getCurrentUser;
  final CreateUser createUser;

  User? _user;
  ViewState _state = ViewState.initial;
  String? _errorMessage;

  UserProvider({
    required this.getCurrentUser,
    required this.createUser,
  });

  User? get user => _user;
  ViewState get state => _state;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _state == ViewState.loading;

  Future<void> fetchUser() async {
    _state = ViewState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await getCurrentUser();
      _state = ViewState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ViewState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> registerUser() async {
    _state = ViewState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await createUser();
      _state = ViewState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ViewState.error;
    } finally {
      notifyListeners();
    }
  }
}
