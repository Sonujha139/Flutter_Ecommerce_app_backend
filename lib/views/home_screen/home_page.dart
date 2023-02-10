import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart_seller/const/const.dart';
import 'package:ekart_seller/services/store_services.dart';
import 'package:ekart_seller/views/products_screen/product_detail.dart';
import 'package:ekart_seller/views/widgets/dashbord_button.dart';
import 'package:ekart_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolors.white,
        automaticallyImplyLeading: false,
        // centerTitle: true,
        title: boldText(text: dashboard, color: Appcolors.fontGrey, size: 16.0),
        actions: [
          Center(
              child: normalText(
                  text: intl.DateFormat('EEE, MMM d, ' 'yy')
                      .format(DateTime.now()),
                  color: Appcolors.fontGrey)),
          10.widthBox
        ],
      ),
      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: Appcolors.purpleColor),
            );
          } else {
            var data = snapshot.data!.docs;
            var n = data.sortedBy((a, b) =>
                b['p_wishlist'].length.compareTo(a['p_wishlist'].length));

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dashbordButton(context,
                          title: product, count: "${data.length}", icon: icproducts),
                      dashbordButton(context,
                          title: orders, count: "15", icon: icOrders),
                    ],
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dashbordButton(context,
                          title: rating, count: "43", icon: icstar),
                      dashbordButton(context,
                          title: totalSales, count: "28", icon: icVerify),
                    ],
                  ),
                  10.heightBox,
                  const Divider(),
                  10.heightBox,
                  boldText(
                      text: popular, color: Appcolors.fontGrey, size: 16.0),
                  20.heightBox,
                  ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          data.length,
                          (index) =>data[index]['p_wishlist'].length == 0 ? const SizedBox() : ListTile(
                                onTap: () {
                                  Get.to(ProductDetails(
                                    data: data[index],
                                  ));
                                },
                                leading: Image.network(
                                  data[index]['p_img'][0],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                title: boldText(
                                    text: "${data[index]['p_name']}",
                                    color: Appcolors.fontGrey,
                                    size: 14.0),
                                subtitle: normalText(
                                    text:
                                        "${data[index]['p_price']}".numCurrency,
                                    color: Appcolors.darkGrey),
                              )))
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
