
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
           radius: 40.0,
           animation: true,
           animationDuration: 1200,
           lineWidth: 15.0,
           percent: 0.4,
           center: const Text("女",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
           circularStrokeCap: CircularStrokeCap.butt,
           backgroundColor: Colors.yellow,
           progressColor: Colors.red,
        ),
        const SizedBox(height: 10),

         LinearProgressBar(
          width: 200,
          animation: true,
          animationDuration: 1000,
          lineHeight: 20.0,
          leading: const Text("左侧内容"),
          trailing: const Text("右侧内容"),
          percent: 0.5,
          center: Text((0.5*100).toString()+'%'),
          barRadius: const Radius.circular(10),
          progressColor: Colors.red,
        ),

        const SizedBox(height: 10),

        Align(child:  CycleProgressBar(
          radius: 40.0,
          lineWidth: 10.0,
          percent: 0.3,
          header: const Text("男30%"),
          center: const Icon(
            Icons.man_rounded,
            size: 50.0,
            color: Colors.blue,
          ),
          backgroundColor: Colors.grey,
          progressColor: Colors.blue,
        )),

      ],
    ));
  }
}
