import 'package:ekart_seller/controllers/profile_controller.dart';
import 'package:ekart_seller/views/widgets/custom_TextField.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import '../widgets/text_style.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        backgroundColor: Appcolors.purpleColor,
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          title: boldText(text: shopSettings, size: 16.0),
          actions: [
            controller.isloading.value
                ? const Center(
                    child: CircularProgressIndicator(color: Appcolors.white))
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      await controller.updateShop(
                        shopaddress: controller.shopaddressController.text,
                        shopname: controller.shopnameController.text,
                        shopwebsite: controller.shopwebsiteController.text,
                        shopdesc: controller.shopDescController.text,
                        shopmobile: controller.shopmobileController.text,
                      );
                      // ignore: use_build_context_synchronously
                      VxToast.show(context, msg: "Shop Update");
                    },
                    child: normalText(
                      text: save,
                    )),
            10.widthBox,
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                customTextField(
                    label: shopname,
                    hint: nameHint,
                    controller: controller.shopnameController),
                10.heightBox,
                customTextField(
                    label: address,
                    hint: shopAddressHint,
                    controller: controller.shopaddressController),
                10.heightBox,
                customTextField(
                    label: mobile,
                    hint: shopMobileHint,
                    controller: controller.shopmobileController),
                10.heightBox,
                customTextField(
                    label: website,
                    hint: shopWebsiteHint,
                    controller: controller.shopwebsiteController),
                10.heightBox,
                customTextField(
                    isDesc: true,
                    label: description,
                    hint: shopDescHint,
                    controller: controller.shopDescController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
