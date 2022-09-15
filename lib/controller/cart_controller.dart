
import 'dart:async';

import 'package:get/get.dart';
import 'package:green_pen/model/cart_model.dart';
import 'package:green_pen/provider/api_provider.dart';

class CartController extends GetxController{

   var cartDataList = List<Cart>.empty(growable: true).obs;
  // Result? readNotificationData;
  var isLoading = false.obs;
  var orderAmount = 0.0.obs;
  var tax = 0.0.obs;
  var totalAmount = 0.0.obs;
  var backButton = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    print("Start");
    //await apiCallingMethod();
    print("End");
    super.onInit();
  }

  Future<void> apiCallingMethod([bool? val]) async {
    backButton = val!;
    await getCartApiData();
  }

  Future<void> getCartApiData() async {
    isLoading.value = true;
    cartDataList.clear();
    orderAmount.value = 0.0;
    tax.value = 0.0;
    totalAmount.value = 0.0;
    await APIProvider().cartAPI(
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status!){
          data.result!.cart!.forEach((cart) {
            cartDataList.add(cart);
          });
          cartDataList.forEach((element) {
            orderAmount.value += double.parse(element.price.toString().split('.').first);
            tax.value += double.parse(element.tax.toString());
            totalAmount.value += double.parse(element.total.toString());
          });
        }
        isLoading.value = false;
      },
      onError: (error) {
        print('Error : ${error}');
        isLoading.value = false;
      },
    );
    update();
  }

   Future<void> getAddToCartApiData(int? packageId) async {
      Map<String, dynamic> input = {
        'package_id': packageId,
      };
     isLoading.value = true;
     await APIProvider().addToCartAPI(
       params: input,
       onSuccess: (data) {
         print('Response 11 addToCartAPI: ${data.status}');
         print('Response 22: ${data.message}');
         if(data.status!){

         }
         isLoading.value = false;
       },
       onError: (error) {
         print('Error : ${error}');
         isLoading.value = false;
       },
     );
     update();
   }

  Future<void> getRemoveCartApiData(int? cartId) async {
    Map<String, dynamic> input ={
      'cart_id': cartId,
    };
    isLoading.value = true;
    await APIProvider().removeToCartAPI(
      params: input,
      onSuccess: (data) {
        print('Response 11 Remove Cart: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status!){
          isLoading.value = false;
          getCartApiData();
        }
      },
      onError: (error) {
        print('Error : ${error}');
        isLoading.value = false;
      },
    );
    update();
  }
}