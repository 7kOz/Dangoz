import 'package:get/get_state_manager/get_state_manager.dart';

class ForexCalendarController extends GetxController {
  String date1 = '';
  String date2 = '';

  updateDate1(String newDate) {
    date1 = newDate;
    update();
  }
}
