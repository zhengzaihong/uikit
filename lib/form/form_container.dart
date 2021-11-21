import 'package:flutter/material.dart';

import 'formhelper.dart';

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


  @override
  Widget build(BuildContext context) {
    return Form(
      key: FormHelper.getGloblkey(),
      child: widget.childWidget(),
    );
  }
}
