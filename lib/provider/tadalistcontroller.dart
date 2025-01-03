import 'package:radius/model/tada.dart';
import 'package:radius/repositories/tadarepository.dart';
import 'package:radius/screen/tadascreen/createtadascreen.dart';
import 'package:radius/screen/tadascreen/edittadascreen.dart';
import 'package:radius/screen/tadascreen/tadadetailscreen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';

class TadaListController extends GetxController {
  final tadaList = <Tada>[].obs;
  TadaRepository repository = TadaRepository();

  Future<String> getTadaList() async {
    try {
      EasyLoading.show(
          status: translate('loader.loading'),
          maskType: EasyLoadingMaskType.black);
      final response = await repository.getTadaList();
      EasyLoading.dismiss(animation: true);

      final list = <Tada>[];

      for (var tada in response.data) {
        list.add(Tada.list(
            tada.id,
            tada.title,
            tada.total_expense,
            tada.status,
            tada.remark,
            tada.submitted_date));
      }

      tadaList.value = list;

      return "Loaded";
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void onTadaClicked(String id) {
    Get.to(const TadaDetailScreen(),
        transition: Transition.cupertino, arguments: {"tadaId": id});
  }

  void onTadaEditClicked(String id) {
    Get.to(const EditTadaScreen(),
        transition: Transition.cupertino, arguments: {"tadaId": id});
  }

  void onTadaCreateClicked() {
    Get.to(const CreateTadaScreen(), transition: Transition.cupertino);
  }

  @override
  void onInit() {
    getTadaList();
    super.onInit();
  }
}
