import 'package:ekart_seller/const/const.dart';
import 'package:ekart_seller/controllers/auth_controller.dart';
import 'package:ekart_seller/views/BottomaNavbar.dart/BottomNavBar.dart';
import 'package:ekart_seller/views/widgets/ourButton.dart';
import 'package:ekart_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Appcolors.purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.heightBox,
              normalText(text: welcome, size: 20.0),
              20.heightBox,
              Row(
                children: [
                  Image.asset(
                    iclogo,
                    width: 70,
                    height: 70,
                  )
                      .box
                      .border(color: Appcolors.white)
                      .padding(const EdgeInsets.all(8))
                      .rounded
                      .make(),
                  10.widthBox,
                  boldText(text: appname, size: 20.0)
                ],
              ),
              30.heightBox,
              Center(
                  child: normalText(
                      text: loginTo, color: Appcolors.lightGrey, size: 18.0)),
              10.heightBox,
              Obx(
                () => Column(
                  children: [
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Appcolors.purpleColor,
                          ),
                          border: InputBorder.none,
                          hintText: emailHint),
                    ),
                    10.heightBox,
                    const Divider(),
                    TextFormField(
                      obscureText: true,
                      controller: controller.passwordController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.key,
                            color: Appcolors.purpleColor,
                          ),
                          border: InputBorder.none,
                          hintText: passwordHint),
                    ),
                    const Divider(),
                    10.heightBox,
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {},
                            child: normalText(
                                text: forgotPassword,
                                color: Appcolors.purpleColor))),
                    20.heightBox,
                    SizedBox(
                        width: context.screenWidth - 100,
                        child: controller.isloading.value ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Appcolors.purpleColor))): ourButton(
                            title: login,
                            onpress: ()async{
                              controller.isloading(true);
                              await controller
                                  .loginMethod(context: context)
                                  .then((value) {
                                if (value != null) {
                                  VxToast.show(context, msg: "Logged in");
                                  controller.isloading(false);
                                  Get.offAll(() => const BottomNavbar());
                                } else {
                                  controller.isloading(false);
                                }
                              });
                            }))
                  ],
                )
                    .box
                    .white
                    .rounded
                    .outerShadowMd
                    .padding(const EdgeInsets.all(8))
                    .make(),
              ),
              10.heightBox,
              Center(
                  child:
                      normalText(text: anyProblem, color: Appcolors.lightGrey)),
              const Spacer(),
              Center(child: boldText(text: credit)),
              20.heightBox
            ],
          ),
        ),
      ),
    );
  }
}
