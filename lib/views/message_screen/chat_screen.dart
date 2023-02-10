import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart_seller/views/message_screen/components/chat_bubble.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import '../../controllers/chat_controller.dart';
import '../../services/store_services.dart';
import '../widgets/text_style.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
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
        backgroundColor: Appcolors.white,
        title: boldText(text: "${controller.senderName}", size: 16.0, color: Appcolors.fontGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
             Obx(
              () => controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Appcolors.red),
                      ),
                    )
                  : Expanded(
                      child: StreamBuilder(
                        stream: StoreServices.getChatMessages(
                            controller.chatDocId.toString()),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Appcolors.red),
                              ),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: "Send a message..."
                                  .text
                                  .color(Appcolors.darkGrey)
                                  .make(),
                            );
                          } else {
                            return ListView(
                              children: snapshot.data!.docs
                                  .mapIndexed((currentValue, index) {
                                var data = snapshot.data!.docs[index];
                                return Align(
                                    alignment: data['uid'] == currentUser!.uid
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: senderBubble(data));
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ),),
            // Expanded(
            //     child: ListView.builder(
            //         itemCount: 20,
            //         itemBuilder: (context, index) {
            //           return chatBubble();
            //         })),
            5.heightBox,
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    decoration: const InputDecoration(
                        isDense: true,
                        hintText: "Enter message",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Appcolors.purpleColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Appcolors.purpleColor),
                        )),
                  )),
                  IconButton(
                      onPressed: () {
                         controller.sendMeg(controller.msgController.text);
                      controller.msgController.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Appcolors.purpleColor,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
