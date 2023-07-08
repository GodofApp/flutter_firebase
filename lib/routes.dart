import 'package:flutter_firebase/views/dashboard.dart';
import 'package:flutter_firebase/views/home_screen.dart';
import 'package:flutter_firebase/views/login_screen.dart';
import 'package:flutter_firebase/views/register_screen.dart';
import 'package:get/get.dart';

class Routes{
  static final routes = [
    GetPage(name: '/homeScreen', page: () => HomeScreen()),
    GetPage(name: '/loginScreen', page: () => LoginScreen()),
    GetPage(name: '/registerScreen', page: () => RegisterScreen()),
    GetPage(name: '/dashboard', page: () => DashBoard()),
  ];
}