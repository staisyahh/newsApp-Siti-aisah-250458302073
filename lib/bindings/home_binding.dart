import 'package:get/get.dart';
import 'package:news_app/controllers/news_controller.dart';

// tempat untuk daftarin controller yang hanya dipakai di home page, biar ga kepake di page lain
// binding punya fungsi wajib yaitu dependecy
class HomeBinding implements Bindings {
  @override
  void dependencies() {
    //get.lazyput biar controller nya cuma buat saat dibutuhkan
    //jadi gak langsung dibuat saat app jalan, tapi baru dibuat saat home page diakses
    Get.lazyPut<NewsController>(() => NewsController());
  }
}