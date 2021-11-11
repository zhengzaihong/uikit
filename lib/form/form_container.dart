import 'package:flutter/material.dart';
import 'package:uikit/form/viewhelper.dart';

typedef DataChild = Widget Function();

class FormContainer extends StatefulWidget {
  final DataChild childWidget;

  const FormContainer({
    Key? key,
    required this.childWidget,
  }) : super(key: key);

  @override
  _FormContainWidgetState createState() => _FormContainWidgetState();
}

class _FormContainWidgetState extends State<FormContainer> {

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: ViewHelper.getGloblkey(),
      child: widget.childWidget(),
    );
  }
}
