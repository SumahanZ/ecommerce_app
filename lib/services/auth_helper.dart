import "dart:convert";

import "package:ecommerce_app/services/config.dart";
import "package:http/http.dart" as http;
import "package:shared_preferences/shared_preferences.dart";

import "../models/auth/login_model.dart";
import "../models/auth/signup_model.dart";
import "../models/auth_response/login_res_model.dart";
import "../models/auth_response/profile_model.dart";

class AuthHelper {
  //if this is true, user can access the pages that need to be authenticated to access
  Future<bool> login(LoginModel model) async {
    Map<String, String> requestHeaders = {"Content-Type": "application/json"};
    var url = Uri.http(Config.apiUrl, Config.loginUrl);
    //call model.toJson() because jsonEncode only takes in basic data types
    var response = await http.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      //if we get response, we need to initialize sharedpreference
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      //make the response we got from the request into a LoginResponseModel type
      //two model (1 for sending the request (LoginModel) and 1 for receiving and decoding the response(LoginResponseModel))
      //we create the token and save it only when the user login, signing up doesnt create a token
      String userToken = loginResponseModelFromJson(response.body).token;
      String userId = loginResponseModelFromJson(response.body).id;

      //save token and userid in local storage, so whenever we close and run the app again we still have that access to that token until user logout or until the token expires
      await prefs.setString("token", userToken);
      await prefs.setString("userId", userId);
      await prefs.setBool("isLogged", true);

      return true;
    } else {
      return false;
    }
  }

  Future<bool> signUp(SignupModel model) async {
    Map<String, String> requestHeaders = {"Content-Type": "application/json"};
    var url = Uri.http(Config.apiUrl, Config.registerUrl);
    var response = await http.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    if (response.statusCode == 201) {
      //after signup success
      //return true
      return true;
    } else {
      //if something happens returns false indicating that the user is not authenticated yet
      return false;
    }
  }

  Future<ProfileRes> getProfile() async {
    //pass the token so we can get the profile
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "token": "Bearer $token"
    };
    var url = Uri.http(Config.apiUrl, Config.getUserUrl);
    var response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      //after signup success
      //return true
      return profileResFromJson(response.body);
    } else {
      throw Exception("Failed to get user profile");
    }
  }
}
