import 'dart:io';

import 'package:ekart_seller/const/const.dart';
import 'package:ekart_seller/controllers/profile_controller.dart';
import 'package:ekart_seller/views/widgets/custom_TextField.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../widgets/text_style.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({super.key, this.username});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();
  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
      Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Appcolors.purpleColor,
        appBar: AppBar(
          //backgroundColor: Appcolors.white,
          title: boldText(text: editProfile, size: 16.0),
          actions: [
             controller.isloading.value
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Appcolors.purpleColor),
                )
              :TextButton(
                onPressed: () async{
                  controller.isloading(true);
    
                          //if image os not selected
                          if (controller.profileImgPath.value.isNotEmpty) {
                            await controller.uploadProfileImage();
                          } else {
                            controller.profileImageLink = controller.snapshortData['imageUrl'];
                          }
    
                          // if old password matches database
    
                          if (controller.snapshortData['password'] ==
                              controller.oldpassController.text) {
                           await controller.changeAuthPassword(
                            email:controller.snapshortData['email'],
                            password: controller.oldpassController.text,
                             newpassword: controller.newpassController.text);
    
                            await controller.updateProfile(
                                imgUrl: controller.profileImageLink,
                                name: controller.nameController.text,
                                password: controller.newpassController.text);
                            VxToast.show(context, msg: "Updated");
                            controller.isloading(false);
                          } else if (controller.oldpassController.text.isEmptyOrNull && controller.newpassController.text.isEmptyOrNull){
                             await controller.updateProfile(
                                imgUrl: controller.profileImageLink,
                                name: controller.nameController.text,
                                password: controller.snapshortData['password']);
                            VxToast.show(context, msg: "Updated");
                            controller.isloading(false);
                          }else{
                            VxToast.show(context, msg: "Some error occured");
                            controller.isloading(false);
                          }
                },
                child: normalText(
                  text: save,
                )),
            10.widthBox
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: 
             Column(
              children: [
          
                 controller.snapshortData['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(imgProduct, width: 100,height: 100, fit: BoxFit.cover)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make()
          
                  //if data is not empty but controller path is empty
                  : controller.snapshortData['imageUrl'] != '' && controller.profileImgPath.isEmpty
                      ? Image.network(
                          controller.snapshortData['imageUrl'],
                          width: 100,height: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
          
                      //if both are empty
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
                // Image.asset(
                //   imgProduct,
                //   width: 150,
                //   height: 150,
                //   fit: BoxFit.cover,
                // ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Appcolors.white),
                    onPressed: () {
                      controller.changeImage(context);
                    },
                    child:
                        normalText(text: changeImage, color: Appcolors.fontGrey)),
                10.heightBox,
                const Divider(
                  color: Appcolors.lightGrey,
                ),
                customTextField(
                    label: name,
                    hint: "eg. Enter your username",
                     controller: controller.nameController,),
                20.heightBox,
                boldText(text: "Change Your Password"),
                20.heightBox,
                customTextField(
                    label: "old password",
                    hint: passwordHint,
                    controller: controller.oldpassController),
                10.heightBox,
                customTextField(
                    label: "new password",
                    hint: passwordHint,
                    controller: controller.newpassController),
              ],
            ),
          
        ),
      ),
    );
  }
}
