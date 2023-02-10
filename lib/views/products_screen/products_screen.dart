import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart_seller/const/const.dart';
import 'package:ekart_seller/services/store_services.dart';
import 'package:ekart_seller/views/products_screen/add_products.dart';
import 'package:ekart_seller/views/products_screen/product_detail.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../controllers/products_controller.dart';
import '../widgets/text_style.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller.getCategories();
          await controller.populateCategoryList();
          Get.to(const AddProducts());
        },
        backgroundColor: Appcolors.purpleColor,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Appcolors.white,
        // centerTitle: true,
        title: boldText(text: product, color: Appcolors.fontGrey, size: 16.0),
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
              child: CircularProgressIndicator(
                color: Appcolors.purpleColor,
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                      data.length,
                      (index) => ListTile(
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
                            subtitle: Row(
                              children: [
                                normalText(
                                    text:
                                        "${data[index]['p_price']}".numCurrency,
                                    color: Appcolors.red),
                                10.widthBox,
                                boldText(
                                    text: data[index]['is_featured'] == true
                                        ? "Featured"
                                        : "",
                                    color: Appcolors.green),
                              ],
                            ),
                            trailing: VxPopupMenu(
                                child: Icon(Icons.more_vert_rounded),
                                menuBuilder: () => Column(
                                      children: List.generate(
                                          popupMenuTitles.length,
                                          (i) => Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      popupMenuIcons[i],
                                                      color: data[index][
                                                                      'featured_id'] ==
                                                                  currentUser!
                                                                      .uid &&
                                                              i == 0
                                                          ? Appcolors.green
                                                          : Appcolors.darkGrey,
                                                    ),
                                                    10.widthBox,
                                                    normalText(
                                                        text: data[index][
                                                                        'featured_id'] ==
                                                                    currentUser!
                                                                        .uid &&
                                                                i == 0
                                                            ? "Remove feature"
                                                            : popupMenuTitles[
                                                                i],
                                                        color:
                                                            Appcolors.darkGrey)
                                                  ],
                                                ).onTap(() {
                                                  switch (i) {
                                                    case 0:
                                                      if (data[index]
                                                              ['is_featured'] ==
                                                          true) {
                                                        controller
                                                            .removeFeatured(
                                                                data[index].id);
                                                        VxToast.show(context,
                                                            msg: "Removed");
                                                      } else {
                                                        controller.addFeatured(
                                                            data[index].id);
                                                        VxToast.show(context,
                                                            msg: "Added");
                                                      }
                                                      break;
                                                    case 1:
                                                      break;
                                                    case 2:
                                                      controller.removeproduct(
                                                          data[index].id);
                                                      VxToast.show(context,
                                                          msg: remove);
                                                      break;
                                                    default:
                                                  }
                                                }),
                                              )),
                                    ).box.rounded.white.width(200).make(),
                                clickType: VxClickType.singleClick),
                          )),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
