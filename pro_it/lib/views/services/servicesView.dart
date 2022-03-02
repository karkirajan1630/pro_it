import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:pro_it/config/currenciesJson.dart';
import 'package:pro_it/controllers/controllers.dart';
import 'package:pro_it/widgets/widgets.dart';

class ServicesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Services',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   GetX<CurrencyController>(builder: (controller) {
        //     return CurrencyDropDown(
        //       items: CurrenciesJson.currencies.keys.toList(),
        //       value: controller.to.value,
        //       onChange: (val) {
        //         controller.changeCurrency(val);
        //       },
        //     );
        //   }),
        // ],
        bottom: _buildBottomBar(),
      ),
      body: Container(
        child: GetX<ProductController>(builder: (productController) {
          return GridView.builder(
            itemCount: productController.productList.length,
            itemBuilder: (context, i) {
              return StaggeredProductTile(
                //key: Key(productController.productList[i].id!),
                product: productController.productList[i],
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              crossAxisCount:
                  (context.orientation == Orientation.portrait) ? 2 : 3,
              childAspectRatio:
                  (Get.width / 2) / ((Get.height - kToolbarHeight - 120) / 2),
            ),
          );
        }),
      ),
    );
  }

  PreferredSize _buildBottomBar() {
    return PreferredSize(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: GetX<ProductController>(builder: (controller) {
            return TextFormField(
              controller: controller.searchController.value,
              onChanged: (val) {
                controller.setQuery(val);
              },
              decoration: InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
                suffixIcon: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Icon(Icons.search),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 13),
              ),
            );
          }),
        ),
      ),
      preferredSize: Size.fromHeight(80.0),
    );
  }
}
