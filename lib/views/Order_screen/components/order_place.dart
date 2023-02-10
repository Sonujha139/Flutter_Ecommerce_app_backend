
import 'package:ekart_seller/views/widgets/text_style.dart';

import '../../../const/const.dart';

Widget orderPlacedetail({title1, title2, detail1, detail2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: "$title1", color: Appcolors.purpleColor),
            boldText(text: "$detail1", color: Appcolors.red),
            // "$title1".text.fontFamily(semibold).make(),
            // "$detail1"
            //     .text
            //     .color(Appcolors.redColor)
            //     .fontFamily(semibold)
            //     .make(),
          ],
        ),
        SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            boldText(text: "$title2", color: Appcolors.purpleColor),
            boldText(text: "$detail2", color: Appcolors.red),
              // "$title2".text.fontFamily(semibold).make(),
              // "$detail2"
              //     .text
              //      .color(Appcolors.fontGrey)
              //     .fontFamily(semibold)
              //     .make(),
            ],
          ),
        ),
      ],
    ),
  );
}
