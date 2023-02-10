import 'package:ekart_seller/const/const.dart';
import 'package:ekart_seller/views/widgets/text_style.dart';

Widget productImages({required label, onPress}) {
  return "$label".text.bold.color(Appcolors.fontGrey).size(16.0).makeCentered()
      .box
      .color(Appcolors.lightGrey).size(100, 100).roundedSM
      .make();
}
