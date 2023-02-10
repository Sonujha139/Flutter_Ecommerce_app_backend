import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart_seller/services/store_services.dart';
import 'package:ekart_seller/views/message_screen/chat_screen.dart';
import 'package:ekart_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../const/const.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Appcolors.fontGrey,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: boldText(text: messages, size: 16.0, color: Appcolors.fontGrey),
      ),
      body: StreamBuilder(
        stream: StoreServices.getMessage(currentUser!.uid),
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
                      children: List.generate(data.length, (index) {
                        var t =
      data[index]['created_on'] == null ? DateTime.now() : data[index]['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
                  return  ListTile(
                      onTap: () {
                        Get.to(const ChatScreen(),arguments: [
                                      data[index]['friend_name'],
                                      data[index]['toId'],]);
                      },
                      leading: const CircleAvatar(
                          backgroundColor: Appcolors.purpleColor,
                          child: Icon(
                            Icons.person,
                            color: Appcolors.white,
                          )),
                      title: boldText(
                          text: "${data[index]['sender_name']}",
                          color: Appcolors.fontGrey),
                      subtitle: normalText(
                          text: "${data[index]['last_msg']}",
                          color: Appcolors.darkGrey),
                      trailing: normalText(
                          text: time, color: Appcolors.darkGrey),
                    );
                  }))),
            );
          }
        },
      ),
    );
  }
}
