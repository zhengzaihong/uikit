import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';
import 'package:uikit_example/utils/toast.dart';

class PagerExample extends StatefulWidget {
  const PagerExample({Key? key}) : super(key: key);

  @override
  State<PagerExample> createState() => _PagerExampleState();
}

class _PagerExampleState extends State<PagerExample> {

  int currentPage = 2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:  Scaffold(
      appBar: AppBar(
        title: const Text("分页组件"),
      ),
      backgroundColor: Colors.white,
      body:Center(
        child: Pager(
          totalCount: 1000,
          pageEach: 10,
          currentPage: currentPage,
          pageIndicatorActiveColor: Colors.purple,
          pageIndicatorColor: Colors.grey,
          checkedPageColor: Colors.lightBlueAccent,
          pageIndicatorHeight: 30,
          pageTextSize: 18,
          showEllipsis: true,
          sideDiff: 1,
          focusBorder: Border.all(
            color: Colors.lightBlueAccent,
          ),
          textStyle: const TextStyle(
            color: Colors.purple,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
          inputTextStyle: const TextStyle(
            color: Colors.lightBlueAccent,
          ),
          inputContentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          outlineInputTextBorder: const OutlineInputTextBorder(
            borderSide: BorderSide(
                color: Colors.lightBlueAccent,
                width: 1.0,
            ),
            childBorderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          errorInputCallback: (){
            showToast("请输入正确的页码");
          },
          pageChange: (totalPages, currentPageIndex) {
            currentPage = currentPageIndex;
            setState(() {

            });
            print("--------------totalPages:$totalPages,currentPageIndex:$currentPageIndex");
          },
        ),
      ),
    ));
  }

}
