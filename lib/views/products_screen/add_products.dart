import 'package:ekart_seller/controllers/products_controller.dart';
import 'package:ekart_seller/views/products_screen/components/product_dropdown.dart';
import 'package:ekart_seller/views/products_screen/components/product_image.dart';
import 'package:ekart_seller/views/widgets/custom_textfield.dart';
import 'package:ekart_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

import '../../const/const.dart';

class AddProducts extends StatelessWidget {
  const AddProducts({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
    List<Color> colors = [
      Colors.black,
      Colors.white,
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.grey,
      Colors.orange,
      Colors.red,
      Colors.teal
    ];
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Appcolors.purpleColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Appcolors.white,
              )),
          title: boldText(
              text: "Add Products", color: Appcolors.white, size: 16.0),
          actions: [
            controller.isloading.value
                ? const Center(
                    child: CircularProgressIndicator(color: Appcolors.white),
                  )
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      await controller.uploadImages();
                      await controller.uploadProduct(context);
                      Get.back();
                    },
                    child: boldText(text: "Save", color: Appcolors.white)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(
                    hint: "eg product name",
                    label: "Product name",
                    controller: controller.pnameController),
                10.heightBox,
                customTextField(
                    hint: "eg enter product description",
                    label: "Description",
                    isDesc: true,
                    controller: controller.pdescController),
                10.heightBox,
                customTextField(
                    hint: "eg enter product price",
                    label: "Price",
                    controller: controller.ppriceController),
                10.heightBox,
                customTextField(
                    hint: "eg 20",
                    label: "Quantity",
                    controller: controller.pquantityController),
                10.heightBox,

                // categroy & subCategory dropdown manu
                productDropdown('Category', controller.categoryList,
                    controller.categoryvalue, controller),
                10.heightBox,
                productDropdown("Subcategory", controller.subcategoryList,
                    controller.subcategoryvalue, controller),
                10.heightBox,
                const Divider(
                  color: Appcolors.lightGrey,
                ),
                // select product image
                boldText(text: "Choose product images"),
                10.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                        3,
                        (index) => controller.pImageList[index] != null
                            ? Image.file(
                                controller.pImageList[index],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ).onTap(() {
                                controller.pickImage(index, context);
                              })
                            : productImages(label: "${index + 1}").onTap(() {
                                controller.pickImage(index, context);
                              })),
                  ),
                ),
                5.heightBox,
                normalText(
                    text: "First image will be your display image",
                    color: Appcolors.lightGrey),
                10.heightBox,
                const Divider(
                  color: Appcolors.lightGrey,
                ),

                // choose colors section
                boldText(text: "Choose product colors"),
                10.heightBox,
                Obx(
                  () => Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                        9,
                        (index) => Stack(
                              alignment: Alignment.center,
                              children: [
                                VxBox()
                                    .color(colors[index])
                                    .roundedFull
                                    .size(65, 65)
                                    .make()
                                    .onTap(() {
                                  controller.changeColorIndex(index);
                                  //controller.selectedColorIndex.value = index;
                                }),
                                controller.selectedColorIndex.value == index
                                    ? const Icon(
                                        Icons.done,
                                        color: Appcolors.white,
                                      )
                                    : const SizedBox()
                              ],
                            )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
