import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'login_service.dart';

class LoginController extends ChangeNotifier {
  final LoginService _loginService;

  LoginController(this._loginService);

  late bool _isLoggedIn;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String phonenumber) async {
    _isLoggedIn = await _loginService.login(phonenumber);
    notifyListeners();
  }

  late bool _isConnectedToInternet;

  bool get isConnectedToInternet => _isConnectedToInternet;

  Future init() async {
    _isConnectedToInternet = true;

    // _isConnectedToInternet = false;
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.mobile) {
    //   // I am connected to a mobile network.
    //   _isConnectedToInternet = true;
    // } else if (connectivityResult == ConnectivityResult.wifi) {
    //   // I am connected to a wifi network.
    //   _isConnectedToInternet = true;
    // } else if (connectivityResult == ConnectivityResult.none) {
    //   _isConnectedToInternet = false;
    // }
    // notifyListeners();
    // Connectivity()
    //     .onConnectivityChanged
    //     .listen((ConnectivityResult connectivityResult) {
    //   // Got a new connectivity status!
    //   if (connectivityResult == ConnectivityResult.mobile) {
    //     // I am connected to a mobile network.
    //     _isConnectedToInternet = true;
    //   } else if (connectivityResult == ConnectivityResult.wifi) {
    //     // I am connected to a wifi network.
    //     _isConnectedToInternet = true;
    //   } else if (connectivityResult == ConnectivityResult.none) {
    //     _isConnectedToInternet = false;
    //   }
    //   notifyListeners();
    // });
  }
}
