import 'package:ecommerce_app/models/auth/login_model.dart';
import 'package:ecommerce_app/models/auth/signup_model.dart';
import 'package:ecommerce_app/widgets/export_packages.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_response/profile_model.dart';
import '../services/auth_helper.dart';

class LoginNotifier with ChangeNotifier {
  bool _isObscure = false;

  bool get isObscure => _isObscure;

  set isObscure(bool newState) {
    _isObscure = newState;
    notifyListeners();
  }


  //when we are processsing our data we need to show that something is happening
  bool _processing = false;

  bool get processing => _processing;

  set processing(bool newState) {
    _processing = newState;
    notifyListeners();
  }

  //for when we login, we need to set the boolean
  //when the user is logged in, we need to change another boolean in our provider to true
  bool _loginResponseBool = false;

  bool get loginResponseBool => _loginResponseBool;

  set loginResponseBool(bool newState) {
    _loginResponseBool = newState;
    notifyListeners();
  }

  bool _responseBool = false;

  bool get responseBool => _responseBool;

  set responseBool(bool newState) {
    _responseBool = newState;
    notifyListeners();
  }

  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }


  Future<bool> userLogin(LoginModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    processing = true;
    bool response = await AuthHelper().login(model);
    processing = false;

    loginResponseBool = response;

    loggedIn = prefs.getBool("isLogged") ?? false;

    return loginResponseBool;
  }

  Future<void> logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    prefs.remove("userId");
    prefs.setBool("isLogged", false);
    loggedIn = prefs.getBool("isLogged") ?? false;
  }


  Future<bool> registerUser(SignupModel model) async {
    responseBool = await AuthHelper().signUp(model);
    return responseBool;
  }

  Future<ProfileRes> getProfile() async {
    return await AuthHelper().getProfile();
  }

  Future<void> getPrefs() async {
    //everytime we open the application we need this function to maintain the auth state when we close the app and open it again
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedIn = prefs.getBool("isLogged") ?? false;
  }

  
}