import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SignupController extends GetxController {
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;
  DateTime birthday = DateTime.now();
  bool checkbox = false;

  updateShowpassword() {
    showPassword = !showPassword;
    update();
  }

  updateBirthday(DateTime date) {
    birthday = date;
    update();
  }

  updateCheckbox() {
    checkbox = !checkbox;
    update();
  }
}
