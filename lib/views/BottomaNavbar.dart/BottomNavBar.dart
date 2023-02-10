import 'package:ekart_seller/const/const.dart';
import 'package:ekart_seller/controllers/bottomNavbar_controller.dart';
import 'package:ekart_seller/views/Order_screen/order_screen.dart';
import 'package:ekart_seller/views/home_screen/home_page.dart';
import 'package:ekart_seller/views/products_screen/products_screen.dart';
import 'package:ekart_seller/views/profile_screen/profile_screen.dart';
import 'package:ekart_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(NavbarController());
    var navScreen = [
      const Homescreen(),
      const ProductScreen(),
      const Orderscreen(),
      const Profilescreen(),
    ];

    var bottomNavbar = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: dashboard),
      BottomNavigationBarItem(
          icon: Image.asset(
            icproducts,
            color: Appcolors.darkGrey,
            width: 24,
          ),
          label: product),
      BottomNavigationBarItem(
          icon: Image.asset(
            icOrders,
            color: Appcolors.darkGrey,
            width: 24,
          ),
          label: orders),
      BottomNavigationBarItem(
          icon: Image.asset(
            icGeneralSetting,
            color: Appcolors.darkGrey,
            width: 24,
          ),
          label: settings),
    ];
    return Scaffold(
      bottomNavigationBar: Obx(()=>
           BottomNavigationBar(
            onTap: (index) {
              controller.navIndex.value = index;
            },
            currentIndex: controller.navIndex.value,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Appcolors.purpleColor,
            unselectedItemColor: Appcolors.darkGrey,
            items: bottomNavbar),
      ),
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: boldText(text: dashboard, color: Appcolors.fontGrey, size: 18.0),
      // ),
      body: Obx(()=>
         Column(
          children: [
            Expanded(child: navScreen.elementAt(controller.navIndex.value))
          ],
        ),
      ),
    );
  }
}
