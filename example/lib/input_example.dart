import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uikit_plus/input/style/inline_style.dart';
import 'package:uikit_plus/uikit_lib.dart';
import 'city_picker_example.dart';

class InputExample extends StatefulWidget {
  const InputExample({Key? key}) : super(key: key);

  @override
  _InputExampleState createState() => _InputExampleState();
}

class _InputExampleState extends State<InputExample> {

  final _formKey = GlobalKey<FormState>();

  ///基础提示样式
  OutlineInputTextBorder allBorder = const OutlineInputTextBorder(
      childBorderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide: BorderSide(
          color: Colors.transparent,
          width: 1
      )
  );
  late OutlineInputBorder errorBorder;
  late OutlineInputBorder focusedErrorBorder;
  late OutlineInputBorder focusedBorder;

  ValueNotifier<String> valueNotifier = ValueNotifier<String>("输入搜索需求：");


  SelectionMenuFormController selectionMenuFormController = SelectionMenuFormController();

  ValueNotifier<FormTips> formTips = ValueNotifier(FormTips.none);

  // Controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final ageController = TextEditingController();
  final urlController = TextEditingController();
  final idCardController = TextEditingController();
  final chineseNameController = TextEditingController();

  // 条件校验示例
  bool isCompanyUser = false;
  final companyNameController = TextEditingController();


  late dynamic debounceInvoker;
  void testDebounce(String label) {
    debugPrint('label: $label @ ${DateTime.now()}');
  }


  @override
  void initState() {
    super.initState();
    focusedBorder = allBorder.copyWith(borderColor: Colors.lightBlue);
    focusedErrorBorder =  allBorder.copyWith(borderColor: Colors.lightBlue);
    errorBorder = allBorder.copyWith(borderColor: Colors.red);
  }

  final textController =TextEditingController();
  final inputController = InputController();

  @override
  Widget build(BuildContext context) {
    debounceInvoker = testDebounce.debounce(milliseconds: 500);
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: (){
            RouteUtils.push(context, const CityPickerExample(),hide: false);
          },
          child: const Text("输入框"),
        ),
      ),
      body: SingleChildScrollView(
        child:  Column(
          children: [

            InputText(
              width: 300,
              margin: const EdgeInsets.only(top: 1),
              hintText: "请输入搜索歌曲名",
              inline: InlineStyle.clearStyle,
              fillColor: Colors.grey.withAlpha(40),
              cursorEnd: true,
              onChanged: (msg){
              },
              controller: textController,
              inputController: inputController,
              onFocusShowPop: true,
              marginTop: 5,
              follower: true,
              popBox: PopBox(
                height: 300,
                width: 300,
              ),
              buildPop: (context){
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('歌手：',style: TextStyle(color: Colors.black,fontSize: 16),),
                      const SizedBox(height: 10,),
                      Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: [
                          ...'张国荣,王力宏,周杰伦,林俊杰,陈奕迅,薛之谦,周笔畅,刘德华'.split(',').map((e) =>  ActionChip(
                            backgroundColor: Colors.grey.withAlpha(10),
                            label: Text(e),
                            onPressed: () {
                              inputController.setText(e);
                            },
                          )).toList()
                        ],
                      ),
                      const SizedBox(height: 20,),
                      const Text('热门歌曲：',style: TextStyle(color: Colors.black,fontSize: 16),),
                      const SizedBox(height: 10,),
                      Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        children: [
                          ...'七里香,青花,白色风车,画沙,一个人,一千个彩虹'.split(',').map((e) =>  ActionChip(
                            backgroundColor: Colors.grey.withAlpha(10),
                            label: Text(e),
                            onPressed: () {
                              inputController.setText(e);
                            },
                          )).toList()
                        ],
                      ),

                    ],
                  ),
                );
              },
            ),
            Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                onChanged: () {
                  _formKey.currentState!.validate();
                },
                child: Column(
                  children: [

                    InputText(
                      width: 300,
                      margin: const EdgeInsets.only(top: 30),
                      // enableForm: f,
                      obscureText: false,
                      noBorder: true,
                      hintText: "请输入手机号-debounce测试",
                      showCursor: true,
                      cursorColor: Colors.red,
                      fillColor: Colors.grey.withAlpha(40),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11),
                      ],
                      onChanged: (msg){
                        debounceInvoker(msg);
                      },

                      controller: TextEditingController(),
                      validator: const InputValidation(
                          mustFill: true,
                          minLength: 11,
                          maxLength: 11,
                          errorMsg: "输入长度不合法").validate,
                      prefixIcon: const Icon(Icons.phone, size: 20, color: Colors.grey),
                      bgRadius: 10,
                      allLineBorder: allBorder,
                      focusedBorder: focusedBorder,
                      focusedErrorBorder: focusedErrorBorder,
                      errorBorder: errorBorder,
                    ),

                    const SizedBox(height: 30),

                    // 1. 用户名校验
                    _buildSection(
                      title: '1. 用户名校验（4-20位字母、数字或下划线）',
                      child: InputText(
                        enableForm: true,
                        controller: usernameController,
                        hintText: "请输入用户名",
                        validator: InputValidation.username(
                          minLength: 4,
                          maxLength: 20,
                        ).validate,
                      ),
                    ),

                    // 2. 邮箱校验
                    _buildSection(
                      title: '2. 邮箱校验',
                      child: InputText(
                        enableForm: true,
                        controller: emailController,
                        hintText: "请输入邮箱",
                        keyboardType: TextInputType.emailAddress,
                        validator: InputValidation.email().validate,
                      ),
                    ),

                    // 3. 手机号校验
                    _buildSection(
                      title: '3. 手机号校验（中国大陆）',
                      child: InputText(
                        enableForm: true,
                        controller: phoneController,
                        hintText: "请输入手机号",
                        keyboardType: TextInputType.phone,
                        validator: InputValidation.phone().validate,
                      ),
                    ),

                    // 4. 密码强度校验
                    _buildSection(
                      title: '4. 密码强度校验（至少8位，包含大小写字母、数字和特殊字符）',
                      child: InputText(
                        enableForm: true,
                        controller: passwordController,
                        hintText: "请输入密码",
                        obscureText: true,
                        validator: InputValidation.strongPassword(
                          minLength: 8,
                        ).validate,
                      ),
                    ),

                    // 5. 密码确认（自定义校验）
                    _buildSection(
                      title: '5. 密码确认（自定义校验）',
                      child: InputText(
                        enableForm: true,
                        controller: confirmPasswordController,
                        hintText: "请再次输入密码",
                        obscureText: true,
                        validator: InputValidation.custom(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "请再次输入密码";
                            }
                            if (value != passwordController.text) {
                              return "两次密码输入不一致";
                            }
                            return null;
                          },
                        ).validate,
                      ),
                    ),

                    // 6. 数字范围校验
                    _buildSection(
                      title: '6. 年龄校验（1-120之间的数字）',
                      child: InputText(
                        enableForm: true,
                        controller: ageController,
                        hintText: "请输入年龄",
                        keyboardType: TextInputType.number,
                        validator: InputValidation.numberRange(
                          min: 1,
                          max: 120,
                          errorMsg: "年龄必须在1-120之间",
                        ).validate,
                      ),
                    ),

                    // 7. URL 校验
                    _buildSection(
                      title: '7. URL 校验',
                      child: InputText(
                        enableForm: true,
                        controller: urlController,
                        hintText: "请输入网址",
                        keyboardType: TextInputType.url,
                        validator: InputValidation.url().validate,
                      ),
                    ),

                    // 8. 身份证号校验
                    _buildSection(
                      title: '8. 身份证号校验（中国大陆）',
                      child: InputText(
                        enableForm: true,
                        controller: idCardController,
                        hintText: "请输入身份证号",
                        validator: InputValidation.idCard().validate,
                      ),
                    ),

                    // 9. 中文校验
                    _buildSection(
                      title: '9. 中文姓名校验',
                      child: InputText(
                        enableForm: true,
                        controller: chineseNameController,
                        hintText: "请输入中文姓名",
                        validator: InputValidation.chinese().validate,
                      ),
                    ),

                    // 10. 条件校验
                    _buildSection(
                      title: '10. 条件校验（勾选企业用户后，公司名称必填）',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxListTile(
                            title: const Text("企业用户"),
                            value: isCompanyUser,
                            contentPadding: EdgeInsets.zero,
                            onChanged: (value) {
                              setState(() {
                                isCompanyUser = value ?? false;
                              });
                            },
                          ),
                          const SizedBox(height: 8),
                          InputText(
                            enableForm: true,
                            controller: companyNameController,
                            hintText: "请输入公司名称",
                            validator: InputValidation.conditional(
                              condition: () => isCompanyUser,
                              validation: const InputValidation(
                                mustFill: true,
                                emptyTip: "企业用户必须填写公司名称",
                              ),
                            ).validate,
                          ),
                        ],
                      ),
                    ),

                    // 11. 组合校验示例
                    _buildSection(
                      title: '11. 组合校验（邮箱或手机号）',
                      child: InputText(
                        enableForm: true,
                        controller: TextEditingController(),
                        hintText: "请输入邮箱或手机号",
                        validator: InputValidation.any([
                          InputValidation.email(),
                          InputValidation.phone(),
                        ], errorMsg: "请输入正确的邮箱或手机号"),
                      ),
                    ),

                    // 提交按钮
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: submitForm,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
                      ),
                      child: const Text(
                        '提交表单',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                    const SizedBox(height: 16),
                    const Text(
                      '提示：点击提交按钮会触发所有输入框的校验',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),

          ],
        ),
      ),
    );
  }
  void submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('表单验证通过！'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('请检查表单输入'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  Widget _buildSection({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
