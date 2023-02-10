import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart_seller/const/const.dart';
import 'package:ekart_seller/services/store_services.dart';
import 'package:ekart_seller/views/Order_screen/order_details.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../widgets/text_style.dart';

class Orderscreen extends StatelessWidget {
  const Orderscreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ordersCollection);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolors.white,
        automaticallyImplyLeading: false,
        // centerTitle: true,
        title: boldText(text: orders, color: Appcolors.fontGrey, size: 16.0),
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
        stream: StoreServices.getOrders(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: Appcolors.purpleColor),
            );
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(data.length, (index) {
                    var time = data[index]['order_date'].toDate();
                    return ListTile(
                      onTap: () {
                        Get.to(OrderDetails(
                          data: data[index],
                        ));
                      },
                      tileColor: Appcolors.textfieldGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      title: boldText(
                          text: "${data[index]['order_code']}",
                          color: Appcolors.purpleColor,
                          size: 14.0),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: Appcolors.fontGrey,
                              ),
                              10.widthBox,
                              boldText(
                                  text:
                                      intl.DateFormat().add_yMd().format(time),
                                  color: Appcolors.fontGrey),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.payment,
                                color: Appcolors.fontGrey,
                              ),
                              10.widthBox,
                              boldText(
                                  text: "${data[index]['payment_method']}",
                                  color: Appcolors.red),
                            ],
                          )
                        ],
                      ),
                      trailing: boldText(
                          text: "${data[index]['total_amount']}".numCurrency,
                          color: Appcolors.purpleColor,
                          size: 16.0),
                    ).box.margin(const EdgeInsets.only(bottom: 4)).make();
                  }),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
