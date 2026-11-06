import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uikit_plus/uikit_lib.dart';

import 'showcase/showcase_scaffold.dart';

class InputExample extends StatefulWidget {
  const InputExample({super.key});

  @override
  State<InputExample> createState() => _InputExampleState();
}

class _InputExampleState extends State<InputExample> {
  final _formKey = GlobalKey<FormState>();

  final _searchController = TextEditingController();
  final _searchInputController = InputController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _ageController = TextEditingController();
  final _urlController = TextEditingController();
  final _idCardController = TextEditingController();
  final _chineseNameController = TextEditingController();
  final _anyController = TextEditingController();
  final _companyNameController = TextEditingController();

  bool _obscurePassword = true;
  bool _isCompanyUser = false;
  String _searchValue = '';
  String _debounceValue = '';
  Timer? _debounceTimer;

  Iterable<TextEditingController> get _controllers => [
        _searchController,
        _usernameController,
        _emailController,
        _phoneController,
        _passwordController,
        _confirmPasswordController,
        _ageController,
        _urlController,
        _idCardController,
        _chineseNameController,
        _anyController,
        _companyNameController,
      ];

  @override
  void dispose() {
    _debounceTimer?.cancel();
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ShowcasePage(
      title: '输入框',
      children: [
        ShowcaseSection(
          title: '搜索联想',
          icon: Icons.search,
          description: '聚焦输入框弹出歌手与歌曲建议，支持点击回填',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputText(
                controller: _searchController,
                inputController: _searchInputController,
                width: double.infinity,
                hintText: '请输入搜索歌曲名',
                inline: InlineStyle.clearStyle,
                fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
                bgRadius: 14,
                prefixIcon: Icon(
                  Icons.search,
                  size: 20,
                  color: scheme.onSurfaceVariant,
                ),
                cursorEnd: true,
                onChanged: (value) {
                  setState(() => _searchValue = value);
                },
                onFocusShowPop: true,
                marginTop: 6,
                follower: true,
                popBox: PopBox(width: 280),
                buildPop: (context) => _buildSearchSuggestions(context),
              ),
              const SizedBox(height: 12),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                child: Container(
                  key: ValueKey(_searchValue),
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                  decoration: BoxDecoration(
                    color: scheme.primaryContainer.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _searchValue.isEmpty
                            ? Icons.lightbulb_outline
                            : Icons.check_circle_outline,
                        size: 18,
                        color: scheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _searchValue.isEmpty
                              ? '输入关键词查看联想结果'
                              : '当前输入：$_searchValue',
                          style: TextStyle(
                            fontSize: 13,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              ShowcaseSection(
                title: '实时校验',
                icon: Icons.verified_outlined,
                description: '用户名、邮箱、手机号、密码与确认密码',
                child: Column(
                  children: [
                    _responsiveGrid(context, [
                      _field(
                        controller: _usernameController,
                        hint: '用户名（4-20 位字母、数字或下划线）',
                        icon: Icons.person_outline,
                        validator: InputValidation.username(
                          minLength: 4,
                          maxLength: 20,
                        ).validate,
                      ),
                      _field(
                        controller: _emailController,
                        hint: '邮箱地址',
                        icon: Icons.alternate_email,
                        keyboardType: TextInputType.emailAddress,
                        validator: InputValidation.email().validate,
                      ),
                      _field(
                        controller: _phoneController,
                        hint: '手机号码（11 位）',
                        icon: Icons.phone_iphone,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(11),
                        ],
                        onChanged: _onPhoneChanged,
                        validator: InputValidation.phone().validate,
                      ),
                      _field(
                        controller: _passwordController,
                        hint: '密码（至少 8 位，包含大小写、数字和特殊字符）',
                        icon: Icons.lock_outline,
                        obscureText: _obscurePassword,
                        suffixIcon: _passwordToggle(context),
                        validator: InputValidation.strongPassword(
                          minLength: 8,
                        ).validate,
                      ),
                      _field(
                        controller: _confirmPasswordController,
                        hint: '再次输入密码',
                        icon: Icons.lock_reset,
                        obscureText: _obscurePassword,
                        suffixIcon: _passwordToggle(context),
                        validator: InputValidation.custom(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '请再次输入密码';
                            }
                            if (value != _passwordController.text) {
                              return '两次密码输入不一致';
                            }
                            return null;
                          },
                        ).validate,
                      ),
                    ]),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 9),
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: scheme.outlineVariant),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.timer_outlined,
                              size: 18, color: scheme.primary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _debounceValue.isEmpty
                                  ? '防抖提示：输入手机号后 500ms 更新状态'
                                  : '防抖结果：$_debounceValue',
                              style: TextStyle(
                                fontSize: 12,
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ShowcaseSection(
                title: '更多校验与条件逻辑',
                icon: Icons.rule,
                description: '数字范围、URL、身份证、中文、组合校验与企业用户条件必填',
                child: Column(
                  children: [
                    _responsiveGrid(context, [
                      _field(
                        controller: _ageController,
                        hint: '年龄（1-120）',
                        icon: Icons.cake_outlined,
                        keyboardType: TextInputType.number,
                        validator: InputValidation.numberRange(
                          min: 1,
                          max: 120,
                          errorMsg: '年龄必须在 1-120 之间',
                        ).validate,
                      ),
                      _field(
                        controller: _urlController,
                        hint: '个人主页 URL',
                        icon: Icons.link,
                        keyboardType: TextInputType.url,
                        validator: InputValidation.url().validate,
                      ),
                      _field(
                        controller: _idCardController,
                        hint: '身份证号',
                        icon: Icons.badge_outlined,
                        validator: InputValidation.idCard().validate,
                      ),
                      _field(
                        controller: _chineseNameController,
                        hint: '中文姓名',
                        icon: Icons.translate,
                        validator: InputValidation.chinese().validate,
                      ),
                      _field(
                        controller: _anyController,
                        hint: '邮箱或手机号',
                        icon: Icons.contact_mail_outlined,
                        validator: InputValidation.any(
                          [
                            InputValidation.email(),
                            InputValidation.phone(),
                          ],
                          errorMsg: '请输入正确的邮箱或手机号',
                        ),
                      ),
                    ]),
                    const SizedBox(height: 4),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => setState(
                          () => _isCompanyUser = !_isCompanyUser),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: scheme.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: _isCompanyUser,
                              onChanged: (value) => setState(
                                  () => _isCompanyUser = value ?? false),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '企业用户',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    '勾选后公司名称变为必填',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: scheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _field(
                      controller: _companyNameController,
                      hint: '公司名称（企业用户必填）',
                      icon: Icons.business_outlined,
                      validator: InputValidation.conditional(
                        condition: () => _isCompanyUser,
                        validation: const InputValidation(
                          mustFill: true,
                          emptyTip: '企业用户必须填写公司名称',
                        ),
                      ).validate,
                    ),
                  ],
                ),
              ),
              ShowcaseSection(
                title: '提交与重置',
                icon: Icons.task_alt,
                description: '提交会触发全部字段校验，重置会清空所有输入',
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _submit,
                        icon: const Icon(Icons.check),
                        label: const Text('提交校验'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _reset,
                        icon: const Icon(Icons.restart_alt),
                        label: const Text('重置表单'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _responsiveGrid(BuildContext context, List<Widget> children) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final twoColumns = constraints.maxWidth >= 640;
        if (!twoColumns) {
          return Column(
            children: [
              for (final child in children)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: child,
                ),
            ],
          );
        }

        final rows = <Widget>[];
        for (var i = 0; i < children.length; i += 2) {
          rows.add(
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: children[i]),
                  const SizedBox(width: 16),
                  Expanded(
                    child: i + 1 < children.length
                        ? children[i + 1]
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          );
        }
        return Column(children: rows);
      },
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    bool obscureText = false,
    int maxLines = 1,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return InputText(
      controller: controller,
      enableForm: true,
      inline: InlineStyle.normalStyle,
      width: double.infinity,
      hintText: hint,
      maxLines: maxLines,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: TextInputAction.next,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      validator: validator,
      onChanged: onChanged,
      prefixIcon: icon == null
          ? null
          : Icon(icon, size: 20, color: scheme.onSurfaceVariant),
      suffixIcon: suffixIcon,
      fillColor: scheme.surfaceContainerLowest,
      bgRadius: 12,
      allLineBorder: _border(scheme.outlineVariant),
      enabledBorder: _border(scheme.outlineVariant),
      focusedBorder: _border(scheme.primary, width: 1.4),
      errorBorder: _border(scheme.error),
      focusedErrorBorder: _border(scheme.error, width: 1.4),
      style: TextStyle(fontSize: 14, color: scheme.onSurface),
      hintStyle: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
    );
  }

  OutlineInputTextBorder _border(Color color, {double width = 1}) {
    return OutlineInputTextBorder(
      childBorderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  Widget _passwordToggle(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return IconButton(
      tooltip: _obscurePassword ? '显示密码' : '隐藏密码',
      icon: Icon(
        _obscurePassword
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined,
        size: 20,
        color: scheme.onSurfaceVariant,
      ),
      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
    );
  }

  Widget _buildSearchSuggestions(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _suggestionGroup(
            context,
            title: '热门歌手',
            values: const ['张国荣', '王力宏', '周杰伦', '林俊杰', '陈奕迅'],
          ),
          const SizedBox(height: 12),
          _suggestionGroup(
            context,
            title: '热门歌曲',
            values: const ['七里香', '青花', '白色风车', '画沙', '一千个彩虹'],
          ),
        ],
      ),
    );
  }

  Widget _suggestionGroup(
    BuildContext context, {
    required String title,
    required List<String> values,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: scheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            for (final value in values)
              ActionChip(
                label: Text(value),
                backgroundColor: scheme.primaryContainer.withValues(alpha: 0.6),
                side: BorderSide.none,
                onPressed: () => _selectSuggestion(value),
              ),
          ],
        ),
      ],
    );
  }

  void _selectSuggestion(String value) {
    _searchInputController.setText(value);
    _searchInputController.removePop();
    setState(() => _searchValue = value);
  }

  void _onPhoneChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() => _debounceValue = value);
    });
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    final valid = _formKey.currentState?.validate() ?? false;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(valid ? '表单校验通过' : '请检查表单输入'),
          backgroundColor: valid ? Colors.green : Colors.red,
        ),
      );
  }

  void _reset() {
    _formKey.currentState?.reset();
    for (final controller in _controllers) {
      controller.clear();
    }
    _debounceTimer?.cancel();
    setState(() {
      _isCompanyUser = false;
      _obscurePassword = true;
      _searchValue = '';
      _debounceValue = '';
    });
  }
}