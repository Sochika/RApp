import 'package:radius/model/advancesalary.dart';
import 'package:radius/repositories/advancesalaryrepository.dart';
import 'package:radius/screen/advancesalary/advancedetailscreen.dart';
import 'package:radius/screen/advancesalary/createadvancesalaryscreen.dart';
import 'package:radius/screen/advancesalary/editadvancesalaryscreen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';

class AdvanceSalaryController extends GetxController {
  final salaryList = <AdvanceSalary>[].obs;
  AdvanceSalaryRepository repository = AdvanceSalaryRepository();

  Future<String> getTadaList() async {
    try {
      EasyLoading.show(
          status: translate('loader.loading'),
          maskType: EasyLoadingMaskType.black);
      final response = await repository.getAdvanceList();
      EasyLoading.dismiss(animation: true);

      final list = <AdvanceSalary>[];
      for (var advance in response.data) {

        list.add(AdvanceSalary(
            advance.id,
            advance.description,
            advance.requested_amount,
            advance.requested_amount,
            advance.status,
            advance.is_settled,
            advance.verified_by,
            advance.remark,
            advance.requested_date));
      }

      salaryList.value = list;
      return "Loaded";
    } catch (e) {
      EasyLoading.dismiss(animation: true);
      print(e);
      rethrow;
    }
  }

  void onAdvanceSalaryClicked(String id) {
    Get.to(const AdvanceDetailScreen(),
        transition: Transition.cupertino, arguments: {"id": id});
  }

  void onAdvanceSalaryEditClicked(String id) {
    Get.to(const EditAdvanceSalaryScreen(),
        transition: Transition.cupertino, arguments: {"id": id});
  }

  void onAdvanceSalaryCreateClicked() {
    Get.to(const CreateAdvanceSalaryScreen(), transition: Transition.cupertino);
  }

  @override
  void onInit() {
    getTadaList();
    super.onInit();
  }
}
