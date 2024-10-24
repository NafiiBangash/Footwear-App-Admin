import 'package:flutter/material.dart';
import 'package:footware_admin/controllers/home_controller.dart';
import 'package:footware_admin/widgets/drop_down_widget.dart';
import 'package:footware_admin/widgets/my_text_field.dart';
import 'package:get/get.dart';
import '../utils/app_const.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {

      return Scaffold(
        appBar: AppBar(
          title: const Text("Add Product"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: AppConst.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Add New Product',
                    style: TextStyle(fontSize: 30, color: Colors.indigoAccent),
                  ),
                  SizedBox(height: 10),
                  MyTextField(
                    label: 'Product Name',
                    controller: ctrl.productNameController,
                  ),
                  SizedBox(height: 10),
                  MyTextField(
                    label: 'Product Description',
                    maxLines: 5,
                    controller: ctrl.productDescriptionController,
                  ),
                  SizedBox(height: 10),
                  MyTextField(
                    label: 'Image Url',
                    controller: ctrl.productImageUrlController,
                  ),
                  SizedBox(height: 10),
                  MyTextField(
                    label: 'Product Price',
                    controller: ctrl.productPriceController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: DropDownWidget(
                        items: const [
                          'Boot',
                          'Shoe',
                          'Beach Shoes',
                          'High Heels'
                        ],
                        selectedItem: ctrl.category,
                        onSelected: (selectedValue) {
                          ctrl.category = selectedValue!;
                          ctrl.update();
                        },
                      )),
                      Expanded(
                          child: DropDownWidget(
                        items: const ['Puma', 'Sketchers', 'Adidas', 'Clarks'],
                        selectedItem: ctrl.brand,
                        onSelected: (selectedValue) {
                          ctrl.brand = selectedValue!;
                          ctrl.update();
                        },
                      )),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('Offer Product ?'),

                  SizedBox(
                    width: AppConst.width,
                    child: DropDownWidget(
                      items: const ['true', 'false'],
                      selectedItem: ctrl.offer.toString(),
                      onSelected: (selectedValue) {
                        ctrl.offer = bool.tryParse(selectedValue!)!;
                        ctrl.update();
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      ctrl.addProduct();
                      ctrl.resetValuesDefault();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigoAccent),
                    child: Text(
                      'Add Product',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
