import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product/product.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;

  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productImageUrlController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  String category = 'Category';
  String brand = 'Brand';
  bool offer = false;

  List<Product> products = [];

  @override
  void onInit() async{
    // TODO: implement onInit
    productCollection = firestore.collection('products');
    await fetchProducts();
    super.onInit();
  }

  resetValuesDefault() {
    productNameController.clear();
    productDescriptionController.clear();
    productImageUrlController.clear();
    productPriceController.clear();
    category = 'General';
    brand = 'un branded';
    offer = false;
    update();
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      List<Product> retrievedProducts = productSnapshot.docs
              .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
              .toList();
      products.clear();
      products.assignAll(retrievedProducts);
      Get.snackbar('Success', 'Product fetched successfully',colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error!', e.toString(),colorText: Colors.red);
      print(e.toString());
    }finally{
      update();
    }
  }

  deleteProduct(String id)async{
    try {
      await productCollection.doc(id).delete();
      fetchProducts();
    } catch (e) {
      Get.snackbar('Error!', e.toString(),colorText: Colors.red);
      print(e);
    }
  }

  addProduct() {
    try {
      DocumentReference doc = productCollection.doc();
      Product product = Product(
          id: doc.id,
          name: productNameController.text,
          category: category,
          description: productDescriptionController.text,
          price: double.tryParse(productPriceController.text),
          brand: brand,
          image: productImageUrlController.text,
          offer: offer);
      final productJson = product.toJson();
      doc.set(productJson);
      Get.snackbar('Success', 'Product added successfully',
          colorText: Colors.green);
    } on Exception catch (e) {
      // TODO
      Get.snackbar('Error', e.toString(), colorText: Colors.green);
    }
  }
}
