import 'package:ekart_seller/const/const.dart';
import 'package:ekart_seller/views/widgets/text_style.dart';

Widget ourButton({title, color = Appcolors.purpleColor, onpress}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      primary: color,
      padding:const EdgeInsets.all(12)
    ),
    onPressed: onpress,
     child: normalText(text: title, size: 16.0));
}