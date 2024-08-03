import 'package:get/get.dart';

import 'Data controller.dart';

class Bindingg extends Bindings{
  @override
  void dependencies() {


    // Get.lazyPut<HomeNav>(() => HomeNav());

    // Get.lazyPut<Data_controller>(() => Data_controller());
    Get.put(Data_controller());
















  }
}