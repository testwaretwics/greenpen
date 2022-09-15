import 'package:get/get.dart';
import 'package:green_pen/provider/api_provider.dart';

class GetMenusController extends GetxController{

  var getMenusDataList = [];
  var isLoading = false.obs;
  var userName = "";
  var userMobile = "";
  var userImage = "";
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getMenusApiData()async {
    isLoading.value = true;
     await APIProvider().getMenusAPI(
      onSuccess: (data) {
        getMenusDataList.clear();
        userName = data.userName.toString();
        print("userName $userName");
        userMobile = data.userMobile.toString();
        print("userMobile $userMobile");
        userImage = data.userImage.toString();
        print("userImage $userImage");
        data.menus!.forEach((element) {
          getMenusDataList.add(element);
        });
        isLoading.value = false;
      },
      onError: (error) {
        print('Error : ${error}');
      },
    );
    update();
  }
}