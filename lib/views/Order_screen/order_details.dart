import 'package:ekart_seller/controllers/orders_controller.dart';
import 'package:ekart_seller/views/widgets/ourButton.dart';
import 'package:ekart_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../const/const.dart';
import 'components/order_place.dart';

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.put(OrdersController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getOrder(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.ondelivery.value = widget.data['order_on_delivery'];
    controller.delivery.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Appcolors.fontGrey,
              )),
          title: boldText(text: "Order details", color: Appcolors.fontGrey),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: ourButton(
                color: Appcolors.green,
                onpress: () {
                  controller.confirmed(true);
                  controller.changeStatus(
                      title: "order_confirmed",
                      status: true,
                      docID: widget.data.id);
                },
                title: "Confirm Order"),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Column(
                  children: [
                    //order delvery status section
                    Visibility(
                      visible: controller.confirmed.value,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          boldText(
                              text: "Order status",
                              color: Appcolors.fontGrey,
                              size: 16.0),
                          SwitchListTile(
                            activeColor: Appcolors.green,
                            value: true,
                            onChanged: (Value) {},
                            title: boldText(
                                text: "Placed", color: Appcolors.fontGrey),
                          ),
                          SwitchListTile(
                            activeColor: Appcolors.green,
                            value: controller.confirmed.value,
                            onChanged: (Value) {
                              controller.confirmed.value = Value;
                            },
                            title: boldText(
                                text: "Confirmed", color: Appcolors.fontGrey),
                          ),
                          SwitchListTile(
                            activeColor: Appcolors.green,
                            value: controller.ondelivery.value,
                            onChanged: (Value) {
                              controller.ondelivery.value = Value;
                              controller.changeStatus(
                                  title: "order_on_delivery",
                                  status: Value,
                                  docID: widget.data.id);
                            },
                            title: boldText(
                                text: "On Delivered",
                                color: Appcolors.fontGrey),
                          ),
                          SwitchListTile(
                            activeColor: Appcolors.green,
                            value: controller.delivery.value,
                            onChanged: (Value) {
                              controller.delivery.value = Value;
                              controller.changeStatus(
                                  title: "order_delivered",
                                  status: Value,
                                  docID: widget.data.id);
                            },
                            title: boldText(
                                text: "Delivered", color: Appcolors.fontGrey),
                          ),
                        ],
                      )
                          .box
                          .padding(const EdgeInsets.all(8))
                          .outerShadowMd
                          .white
                          .border(color: Appcolors.lightGrey)
                          .roundedSM
                          .make(),
                    ),

                    //order details section
                    orderPlacedetail(
                      title1: "Order code",
                      detail1: "${widget.data['order_code']}",
                      title2: "Shipping Method",
                      detail2: "${widget.data['shipping_method']}",
                    ),
                    orderPlacedetail(
                      title1: "Order Date",
                      detail1: intl.DateFormat()
                          .add_yMd()
                          .format((widget.data['order_date'].toDate())),
                      title2: "Payment Method",
                      detail2: "${widget.data['payment_method']}",
                    ),
                    orderPlacedetail(
                      title1: "Payment status",
                      detail1: "${widget.data['shipping_method']}",
                      title2: "Delivery Status",
                      detail2: "Order Placed",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // "Shipping Address".text.fontFamily(semibold).make(),
                              boldText(
                                  text: "Shipping Address",
                                  color: Appcolors.purpleColor),
                              "Name:- "
                                      " ${widget.data['order_by_name']}"
                                  .text
                                  .make(),
                              "Email:- "
                                      " ${widget.data['order_by_email']}"
                                  .text
                                  .make(),
                              "Address:- "
                                      " ${widget.data['order_by_address']}"
                                  .text
                                  .make(),
                              "City:- "
                                      " ${widget.data['order_by_city']}"
                                  .text
                                  .make(),
                              "State:- "
                                      " ${widget.data['order_by_state']}"
                                  .text
                                  .make(),
                              "Pin Code:- "
                                      " ${widget.data['order_by_postalcode']}"
                                  .text
                                  .make(),
                              "Country:- "
                                      " ${widget.data['order_by_country']}"
                                  .text
                                  .make(),
                              "Phone:- "
                                      " ${widget.data['order_by_phone']}"
                                  .text
                                  .make(),
                            ],
                          ),
                          SizedBox(
                            width: 110,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                boldText(
                                    text: "Total Amount",
                                    color: Appcolors.purpleColor),
                                boldText(
                                    text: "${widget.data['total_amount']}"
                                        .numCurrency,
                                    color: Appcolors.purpleColor),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
                    .box
                    .outerShadowMd
                    .white
                    .border(color: Appcolors.lightGrey)
                    .roundedSM
                    .make(),
                const Divider(),
                10.heightBox,
                boldText(
                    text: "Order Products",
                    color: Appcolors.fontGrey,
                    size: 16.0),
                10.heightBox,
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(controller.orders.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlacedetail(
                            title1: "${controller.orders[index]['title']}",
                            title2: "${controller.orders[index]['tprice']}",
                            detail1: "${controller.orders[index]['qty']} X",
                            detail2: "Refundable"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: 30,
                            height: 20,
                            color: Color(controller.orders[index]['color']),
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  }).toList(),
                )
                    .box
                    .outerShadowMd
                    .white
                    .margin(const EdgeInsets.only(bottom: 4))
                    .make(),
                20.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
