

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' as intl;

import '../../../const/const.dart';

Widget senderBubble(DocumentSnapshot data) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
  return Directionality(
    textDirection: data['uid'] == currentUser!.uid ? TextDirection.rtl: TextDirection.ltr,
    child: Container(
      //width: 200,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: data['uid'] == currentUser!.uid ? Appcolors.fontGrey: Appcolors.fontGrey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: "${data['msg']}".text.white.size(16).make(),
          ),
          10.heightBox,
          time
              .text
              .color(Appcolors.white.withOpacity(0.5))
              .make(),
        ],
      ),
    ),
  );
}



// import 'package:ekart_seller/const/const.dart';
// import 'package:ekart_seller/views/widgets/text_style.dart';

// Widget chatBubble(){
//   return  Directionality(
//     // textDirection: data['uid'] == currentUser!.uid ? TextDirection.rtl: TextDirection.ltr,
//     textDirection: TextDirection.ltr,
//     child: Container(
//       //width: 200,
//       padding: const EdgeInsets.all(12),
//       margin: const EdgeInsets.only(bottom: 8),
//       decoration:const BoxDecoration(
//           // color: data['uid'] == currentUser!.uid ? Appcolors.fontGrey: Appcolors.darkFontGrey,
//          color: Appcolors.purpleColor,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//             bottomLeft: Radius.circular(20),
//             bottomRight: Radius.circular(20),
//           )),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 8),
//             child: //"${data['msg']}".text.white.size(16).make(),
//             normalText(text: "Your Message hare")
//           ),
//           10.heightBox,
//           // time
//           //     .text
//           //     .color(Appcolors.white.withOpacity(0.5))
//           //     .make(),
//           normalText(text: "10:45 pm")
//         ],
//       ),
//     ),
//   );
// }