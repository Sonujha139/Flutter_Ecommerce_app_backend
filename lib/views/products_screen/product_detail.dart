import 'package:ekart_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

import '../../const/const.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Appcolors.fontGrey,
            )),
        title: boldText(
            text: "${data['p_name']}", color: Appcolors.fontGrey, size: 16.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // swiper section (consoleslider)
            VxSwiper.builder(
                height: 300,      
                itemCount: data['p_img'].length,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                 autoPlay: true,
                itemBuilder: (context, index) {
                  return Image.network(
                    data["p_img"][index],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                }),
            10.heightBox,
            // title and detail section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(
                      text: "${data['p_name']}",
                      color: Appcolors.fontGrey,
                      size: 16.0),
                  
                  10.heightBox,
                  Row(
                    children: [
                      boldText(
                          text: "${data['p_category']}",
                          color: Appcolors.fontGrey,
                          size: 16.0),
                      10.widthBox,
                      normalText(
                          text: "${data['p_subcategry']}",
                          color: Appcolors.fontGrey,
                          size: 16.0)
                    ],
                  ),
                  10.heightBox,
                  //rating section
                  VxRating(
                    isSelectable: false,
                     value: double.parse(data['p_rating']),
                    onRatingUpdate: (value) {},
                    normalColor: Appcolors.textfieldGrey,
                    selectionColor: Appcolors.golden,
                    count: 5,
                    size: 25,
                    maxRating: 5,
                  ),
                  10.heightBox,
                  boldText(text: "${data['p_price']}".numCurrency, color: Appcolors.red, size: 18.0),

                  20.heightBox,

                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(
                                text: "Color", color: Appcolors.fontGrey),
                           
                          ),
                          Row(
                            children: List.generate(
                              data['p_colors'].length,
                              (index) => VxBox()
                                  .size(40, 40)
                                  .roundedFull
                                  .color(Color(data['p_colors'][index])
                                      .withOpacity(1.0))
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .make()
                                  .onTap(() {}),
                            ),
                          ),
                        ],
                      ).box.padding(const EdgeInsets.all(8)).make(),
                      10.heightBox,
                      // quantity row
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(
                                text: "Quantity", color: Appcolors.fontGrey),
                            // child: "Quantity"
                            //     .text
                            //     .color(Appcolors.textfieldGrey)
                            //     .make(),
                          ),
                          normalText(
                              text: "${data['p_quantity']} items", color: Appcolors.fontGrey),
                        ],
                      ).box.padding(EdgeInsets.all(8)).make(),
                    ],
                  ).box.white.padding(const EdgeInsets.all(8)).make(),
                  20.heightBox,
                  const Divider(),
                  //description section
                  boldText(text: "Description", color: Appcolors.fontGrey),
                  // "Description"
                  //     .text
                  //     .color(Appcolors.darkFontGrey)
                  //     .fontFamily(semibold)
                  //     .make(),
                  10.heightBox,
                  normalText(
                      text: "${data['p_desc']}",
                      color: Appcolors.fontGrey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
