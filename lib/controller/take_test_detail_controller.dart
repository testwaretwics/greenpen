
import 'package:get/get.dart';
import 'package:green_pen/model/take_test_detail_model.dart';
import 'package:green_pen/provider/api_provider.dart';
import 'package:intl/intl.dart';

class TakeTestDetailController extends GetxController{

  var isLoading = false.obs;
  var mcqTestDataList = List<McqTest>.empty(growable: true).obs;
  Package? packageData;
  DateTime? currentDate;
  DateTime selectedDate = DateTime.now();
  List mcqTestTimingList = [];
  DateTime? apiDateTime;
  int mcqTestTimingTodayListLength = 0;
  int mcqTestTimingUpComingListLength = 0;
  int mcqTestTimingSkippedListLength = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getApiDataCalling (int? id) async {
   await takeTestDetailApiData(id);
  }

  timingList (int selectedIndexInTab){
    mcqTestTimingList.clear();
    currentDate = DateFormat('dd-MMM-yyyy').parse(DateFormat("dd-MMM-yyyy").format(DateTime.now()));
    for(int i = 0; mcqTestDataList.length > i; i++){
      apiDateTime = DateFormat("dd-MMM-yyyy").parse(mcqTestDataList[i].date.toString());
      print(" $i For : ${apiDateTime}");
      // DT1 is after DT2
      if(currentDate!.compareTo(apiDateTime!) > 0 && selectedIndexInTab == 2){
        mcqTestTimingList.add(mcqTestDataList[i]);
        mcqTestTimingSkippedListLength = mcqTestTimingList.length;
      } else
        // DT1 is before DT2
      if(currentDate!.compareTo(apiDateTime!) < 0 && selectedIndexInTab == 3){
        mcqTestTimingList.add(mcqTestDataList[i]);
        mcqTestTimingUpComingListLength = mcqTestTimingList.length;
      } else
        // DT1 is DT2
      if(currentDate!.compareTo(apiDateTime!) == 0 && selectedIndexInTab == 1){
        mcqTestTimingList.add(mcqTestDataList[i]);
        mcqTestTimingTodayListLength = mcqTestTimingList.length;
      }
    }
    print("takeTestDetail4Controller.upComingList :- ${mcqTestTimingList.length}");
  }

 Future <void> takeTestDetailApiData(int? id) async {
    isLoading.value = true;
    mcqTestDataList.clear();
    await APIProvider().takeTestDetailAPI(
      // params: input,
      id: id,
      onSuccess: (data) {
        print('Response  : ${data.status}');
        print('Response : ${data.status}');
        print('Response : ${data.message}');

        if (data.status!){
          packageData = data.result!.package;
          data.result!.mcqTest!.forEach((element) {
            mcqTestDataList.add(element);
          });
          print("mcqTestDataList :- ${mcqTestDataList.length}");

          // mcqTestDataList.forEach((element) {
          //   mcqTestTimingList.add(element);
          // });

          // mcqTestTimingList length manage
          // currentDate = DateFormat('dd-MMM-yyyy').parse(DateFormat("dd-MMM-yyyy").format(DateTime.now()));
          // for(int i = 0; mcqTestDataList.length > i; i++){
          //   apiDateTime = DateFormat("dd-MMM-yyyy").parse(mcqTestDataList[i].date.toString());
          //   // DT1 is before DT2 - Skipped
          //   if(currentDate!.compareTo(apiDateTime!) > 0 ){
          //     mcqTestTimingSkippedListLength += 1;
          //   } else
          //     // DT1 is after DT2 - UpComing
          //   if(currentDate!.compareTo(apiDateTime!) < 0){
          //     mcqTestTimingUpComingListLength += 1;
          //   } else
          //     // DT1 is DT2 - Today
          //   if(currentDate!.compareTo(apiDateTime!) == 0){
          //     mcqTestTimingList.add(mcqTestDataList[i]);
          //     mcqTestTimingTodayListLength += 1;
          //   }
          // }


        }
        isLoading.value = false;
      },
      onError: (error) {
        print('Error : $error');
        isLoading.value = false;
      },
    );
    update();
  }

}