import 'package:ekart_seller/const/const.dart';
import 'package:ekart_seller/views/widgets/text_style.dart';

Widget dashbordButton(context, {title, count, icon}) {
  var size = MediaQuery.of(context).size;
  return Row(
    children: [
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          boldText(text: title, size: 16.0),
          boldText(text: count, size: 20.0)
        ],
      )),
      Image.asset(
        icon,
        width: 40,
        color: Appcolors.white,
      )
    ],
  )
      .box
      .color(Appcolors.purpleColor)
      .rounded
      .size(size.width * 0.4, 80)
      .padding(const EdgeInsets.all(8))
      .make();
}
