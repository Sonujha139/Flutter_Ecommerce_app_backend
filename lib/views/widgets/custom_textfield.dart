import 'package:ekart_seller/const/const.dart';
import 'package:ekart_seller/views/widgets/text_style.dart';

Widget customTextField({label, hint, controller, isDesc = false}) {
  return TextFormField(
    controller: controller,
    style:const TextStyle(color: Appcolors.white),
    maxLines: isDesc ? 4:1,
    decoration: InputDecoration(
      isDense: true,
      label: normalText(text: label),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color:Appcolors.white )),
        focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color:Appcolors.white )),
        // enabledBorder: OutlineInputBorder(
        // borderRadius: BorderRadius.circular(12),
        // borderSide: const BorderSide(color:Appcolors.white )), 
      hintText: hint,
      hintStyle: TextStyle(color: Appcolors.lightGrey.withOpacity(0.4))
    ),
  );
}
