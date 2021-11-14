
import 'package:flutter/material.dart';

/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021-11-13
/// create_time: 19:08
/// describe: 自定义标签
///
abstract class LaybelWidget extends StatelessWidget {
  Widget createLabel();
  @override
  Widget build(BuildContext context) {
    return createLabel();
  }
}
