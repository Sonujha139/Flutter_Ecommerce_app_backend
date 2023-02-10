import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart_seller/const/const.dart';
import 'package:ekart_seller/models/category_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'bottomNavbar_controller.dart';

class ProductsController extends GetxController {
  var isloading = false.obs;
  // text field controller

  var pnameController = TextEditingController();
  var pdescController = TextEditingController();
  var ppriceController = TextEditingController();
  var pquantityController = TextEditingController();

  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;

  List<Category> category = [];
  var pImagesLink = [];
  var pImageList = RxList<dynamic>.generate(3, (index) => null);

  var categoryvalue = ''.obs;
  var subcategoryvalue = ''.obs;
  var selectedColorIndex = 0.obs;

  changeColorIndex(index) {
    selectedColorIndex.value = index;
  }

  getCategories() async {
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.category;
  }

  populateCategoryList() {
    categoryList.clear();
    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  populateSubCategoryList(cat) {
    subcategoryList.clear();
    var data = category.where((element) => element.name == cat).toList();

    for (var i = 0; i < data.first.subcategory.length; i++) {
      subcategoryList.add(data.first.subcategory[i]);
    }
  }

  pickImage(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 90);
      if (img == null) {
        return;
      } else {
        pImageList[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImages() async {
    pImagesLink.clear();
    for (var item in pImageList) {
      if (item != null) {
        var filename = basename(item.path);
        var destination = 'images/vendors/${currentUser!.uid}/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();

        pImagesLink.add(n);
      }
    }
  }

  uploadProduct(context) async {
    var store = firestore.collection(productsCollection).doc();
    await store.set({
      'is_featured': false,
      'p_category': categoryvalue.value,
      'p_subcategry': subcategoryvalue.value,
      'p_colors': FieldValue.arrayUnion([
        selectedColorIndex.value
        // Colors.red,
        // Colors.black,
        // Colors.grey,
        // Colors.purple
      ]),
      'p_img': FieldValue.arrayUnion(pImagesLink),
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_desc': pdescController.text,
      'p_name': pnameController.text,
      'p_price': ppriceController.text,
      'p_quantity': pquantityController.text,
      'p_seller': Get.find<NavbarController>().username,
      'p_rating': "4.5",
      'vendor_id': currentUser!.uid,
      'featured_id': ''
    });
    isloading(false);
    VxToast.show(context, msg: "Product uploaded");
  }

  // add futured
  addFeatured(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'featured_id': currentUser!.uid,
      'is_featured': true,
    }, SetOptions(merge: true));
  }

  // remove future
  removeFeatured(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'featured_id': currentUser!.uid,
      'is_featured': false,
    }, SetOptions(merge: true));
  }

  removeproduct(docId) async {
    await firestore.collection(productsCollection).doc(docId).delete();
  }
}
