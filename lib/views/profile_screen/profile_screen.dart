import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart_seller/const/const.dart';
import 'package:ekart_seller/controllers/profile_controller.dart';
import 'package:ekart_seller/services/store_services.dart';
import 'package:ekart_seller/views/auth_screen/login_screen.dart';
import 'package:ekart_seller/views/message_screen/message_screen.dart';
import 'package:ekart_seller/views/profile_screen/edit_profilescreen.dart';
import 'package:ekart_seller/views/shop_screen/shop_settingsscreen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../controllers/auth_controller.dart';
import '../widgets/text_style.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: Appcolors.purpleColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        //backgroundColor: Appcolors.white,
        title: boldText(text: settings, color: Appcolors.white, size: 18.0),
      ),
      body: FutureBuilder(
        future: StoreServices.getProfile(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Appcolors.white)),
            );
          } else {
            controller.snapshortData = snapshot.data!.docs[0];

            return Column(
              children: [
                ListTile(
                
                  leading:  controller.snapshortData['imageUrl'] == ''
                            ? Image.asset(imgProduct,
                                    width: 100,height: 90,  fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make()
                            : Image.network(controller.snapshortData['imageUrl'],
                                    width: 100,height: 90,  fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make(),
                  // leading: Image.asset(imgProduct)
                  //     .box
                  //     .roundedFull
                  //     .clip(Clip.antiAlias)
                  //     .make(),
                  title: boldText(text: "${controller.snapshortData['vendor_name']}", size: 16.0),
                  subtitle: normalText(text: "${controller.snapshortData['email']}"),
                ),
                const Divider(),
                10.heightBox,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: List.generate(
                        profileButtonsIcons.length,
                        (index) => ListTile(
                              onTap: () async {
                                switch (index) {
                                  case 0:
                                    Get.to(const ShopSettings());
                                    break;
                                  case 1:
                                    Get.to(const MessageScreen());
                                    break;
                                  case 2:
                                    Get.to( EditProfileScreen(
                                      username: controller.snapshortData['vendor_name'],
                                    ));
                                    break;
                                  case 3:
                                    await Get.find<AuthController>()
                                        .signoutMethod(context);
                                    Get.offAll(const LoginScreen());

                                    break;
                                  default:
                                }
                              },
                              leading: Icon(
                                profileButtonsIcons[index],
                                color: Appcolors.white,
                              ),
                              title:
                                  normalText(text: profileButtonsTitles[index]),
                            )),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
