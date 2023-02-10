import 'package:get/get.dart';

import '../const/firebase_const/firebase_const.dart';

class NavbarController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUsername();
  }

  var navIndex = 0.obs;
  var username = '';

  getUsername() async {
    var n = await firestore
        .collection(vendorsCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['vendor_name'];
      }
    });
    username = n;
  }
}
