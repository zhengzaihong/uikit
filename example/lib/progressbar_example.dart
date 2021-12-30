
import 'package:flutter/material.dart';
import 'package:uikit/progress/cycle_progress_bar.dart';
import 'package:uikit/progress/linear_progress_bar.dart';


class ProgressBarExample extends StatelessWidget {

  const ProgressBarExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.deepPurple,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
      children:  [

        Row(children: const [Expanded(child: SizedBox(height: 20))]),

        const CycleProgressBar(
          enableAnimation: true,
          animationTime: 6000,
          height: 100,
          width: 100,
          angle: 200,
          progressBgColor: Colors.red,
          cycleBgColor: Colors.grey,
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
          bgColor: Colors.grey,
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
              angle:( 50.0/100.0)*360,
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
