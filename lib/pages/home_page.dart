import 'package:flutter/material.dart';
import 'package:footware_admin/controllers/home_controller.dart';
import 'package:footware_admin/pages/add_product_page.dart';
import 'package:footware_admin/utils/app_const.dart';
import 'package:get/get.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Footware Admin'),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: AppConst.height,
              width: AppConst.width,
              child: ListView.builder(
                itemCount: ctrl.products.length,
                  itemBuilder: (context,index){
                return ListTile(
                  title: Text(ctrl.products[index].name!),
                  subtitle: Text(ctrl.products[index].price!.toString()),
                  trailing: IconButton(onPressed: (){
                    ctrl.deleteProduct(ctrl.products[index].id!);
                  }, icon: Icon(Icons.delete)),
                );
              }),
            ),
          ),
          floatingActionButton: FloatingActionButton(onPressed: (){
            Get.to(()=> const AddProductPage());
          },
          child: Icon(Icons.add),),
        );
      }
    );
  }
}
