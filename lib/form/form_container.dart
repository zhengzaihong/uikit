import 'package:flutter/material.dart';
import 'package:uikit/form/viewhelper.dart';

class FormContainer extends StatefulWidget {

  const FormContainer({
    Key? key,


  }) : super(key: key);

  @override
  _FormContainWidgetState createState() => _FormContainWidgetState();
}

class _FormContainWidgetState extends State<FormContainer> {

  GlobalKey _formKey = GlobalKey<FormState>();


  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildInput(),

    );
  }
}
