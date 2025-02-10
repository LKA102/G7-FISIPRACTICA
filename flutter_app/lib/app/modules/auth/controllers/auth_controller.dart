import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  // Selected usert type index
  var selectedUserTypeIndex = Rx<int>(-1);

  // Login Form Fields
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  // Register Form Fields


  void setUserTypeIndex(int index){
    selectedUserTypeIndex.value = index;
  }

  void submit() {
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();
      print('Email: $loginEmailController, Password: $loginPasswordController');
    }
  }

}