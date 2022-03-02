import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:pro_it/controllers/controllers.dart';
import 'package:pro_it/models/models.dart';
import 'package:pro_it/utilities/utls.dart';
import 'package:pro_it/widgets/widgets.dart';

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: GetX<CartController>(
              builder: (controller) {
                if (controller.cartItemList.length == 0) {
                  return Center(
                    child: Text("Your cart is empty"),
                  );
                }
                return ListView.builder(
                  itemCount: controller.cartItemList.length,
                  itemBuilder: (_, i) {
                    CartItem item = controller.cartItemList[i];
                    return CartItemTile(
                      key: Key(item.id.toString()),
                      cartItem: item,
                    );
                  },
                );
              },
            ),
          ),
          GetX<CartController>(
            builder: (controller) {
              return CheckoutSection(
                price: controller.totalPrice,
                onCheckout: () async {
                  try {
                    if (controller.cartItemList.length == 0) {
                      throw Exception(
                          "Your cart is empty. Add some for checkout");
                    }
                    ConnectivityResult connectivity =
                        await Connectivity().checkConnectivity();
                    if (connectivity == ConnectivityResult.none) {
                      throw Exception("You are not connected to the internet");
                    }

                    Order order = Order(
                      userId: Utils.getUsername(
                          Get.find<FirebaseAuthController>().user!.email!),
                      totalAmount: controller.totalPrice,
                      orderState: "Pending",
                      orderedItems: controller.cartItemList.map((cartItem) {
                        OrderedItem orderedItem = OrderedItem(
                          name: cartItem.name,
                          imageUrl: cartItem.imageUrl,
                          price: cartItem.price,
                          productId: cartItem.productId,
                          quantity: cartItem.quantity,
                        );
                        return orderedItem;
                      }).toList(),
                      orderDate: DateTime.now(),
                    );
                    final payConfig = PaymentConfig(
                      amount: order.totalAmount.toInt() * 100,
                      productIdentity: order.orderedItems[0].productId,
                      productName: order.orderedItems[0].name,
                    );
                    KhaltiScope.of(context).pay(
                        config: payConfig,
                        preferences: [
                          PaymentPreference.khalti,
                        ],
                        onSuccess: (success) async {
                          Get.snackbar("Success", "Payment succeded");
                          await Get.find<OrderController>()
                              .submitOrder(order)
                              .then((value) {
                            controller.deleteCart();
                            Utils.showSnackBar(
                                "Success", "Your order is placed successfully");
                          });
                        },
                        onFailure: (failure) {
                          log(failure.toString());
                          Get.snackbar("Failed", "Payment failed");
                        },
                       );
                  } catch (e) {
                    Utils.showSnackBar("Sorry!!!",
                        "${Utils.getExceptionMessage(e.toString())}");
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }
}
