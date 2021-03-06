
import 'package:flutter/material.dart';
import 'package:flutter_uikit_forzzh/uikitlib.dart';


class ProgressBarExample extends StatelessWidget {

  const ProgressBarExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("ProgressBar"),
      ),
      backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
      children:  [

        Row(children: const [Expanded(child: SizedBox(height: 20))]),

         CycleProgressBar(
          enableAnimation: true,
          animationTime: 6000,
          height: 100,
          width: 100,
          angle: 200,
          progressBgColor: Colors.red,
          cycleBgColor: Colors.teal.withOpacity(0.5),
        ),
        const SizedBox(height: 10),

        const LinearProgressBar(
          enableAnimation: true,
          animationTime: 6000,
          height: 10,
          strokeWidth: 10,
          width: 100,
          progress: 30,
          progressBgColor: Colors.red,
          bgColor: Colors.lightBlue,
        ),

        const SizedBox(height: 10),

        Container(
          height: 100,
          width: 100,
          child: Stack(
          children: const [

            Align(child:  CycleProgressBar(
              enableAnimation: true,
              animationTime: 6000,
              height: 100,
              width: 100,
              angle:( 30.0/100.0)*360,
              strokeWidth: 10,
              progressBgColor: Colors.red,
              cycleBgColor: Colors.grey,
            )),

            Align(child: Text("进度30%",style: TextStyle(color: Colors.lightBlue,fontSize: 12)))
          ],
        ),)

      ],
    ));
  }
}
