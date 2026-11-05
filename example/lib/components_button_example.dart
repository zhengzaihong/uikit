import 'package:flutter/material.dart';
import 'package:uikit_plus/uikit_lib.dart';

import 'showcase/showcase_scaffold.dart';

class ComponentsButtonExample extends StatefulWidget {
  const ComponentsButtonExample({super.key});

  @override
  State<ComponentsButtonExample> createState() =>
      _ComponentsButtonExampleState();
}

class _ComponentsButtonExampleState extends State<ComponentsButtonExample> {
  String _selected = '';

  void _showMessage(String text) {
    setState(() => _selected = text);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  Widget _dialogContent(BuildContext context, String text) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 4)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 42),
              vGap(12),
              Text(text, style: const TextStyle(fontSize: 16)),
              vGap(16),
              ElevatedButton(
                onPressed: GlobalDialog.hide,
                child: const Text('关闭'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShowcasePage(
      title: '按钮与弹窗',
      children: [
        ShowcaseSection(
          title: 'FloatExpendButton 悬浮展开菜单',
          description: '支持 left / right / top / bottom 四个展开方向',
          child: Column(
            children: [
              for (final type in ButtonType.values)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: FloatExpendButton(
                      type: type,
                      fabHeight: 36,
                      iconSize: 16,
                      tabSpace: 10,
                      iconList: [
                        FloatButtonStyle(
                          tabColor: Colors.blue,
                          icon: const Icon(Icons.edit, size: 16),
                        ),
                        FloatButtonStyle(
                          tabColor: Colors.green,
                          icon: const Icon(Icons.share, size: 16),
                        ),
                        FloatButtonStyle(
                          tabColor: Colors.orange,
                          icon: const Icon(Icons.delete, size: 16),
                        ),
                      ],
                      callback: (index) =>
                          _showMessage('${type.name} 方向第 $index 个按钮'),
                    ),
                  ),
                ),
            ],
          ),
        ),
        ShowcaseSection(
          title: 'GlobalDialog 全局对话框',
          description: '支持自动消失、重复调用重置倒计时和手动关闭',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton(
                onPressed: () => GlobalDialog.show(
                  context: context,
                  duration: const Duration(seconds: 2),
                  builder: (ctx) => _dialogContent(ctx, '2 秒后自动关闭'),
                ),
                child: const Text('自动关闭'),
              ),
              ElevatedButton(
                onPressed: () => GlobalDialog.show(
                  context: context,
                  builder: (ctx) => _dialogContent(ctx, '需要手动关闭'),
                ),
                child: const Text('手动关闭'),
              ),
              OutlinedButton(
                onPressed: GlobalDialog.hide,
                child: const Text('立即关闭'),
              ),
            ],
          ),
        ),
        ShowcaseSection(
          title: 'PopRoute 自定义浮层',
          description: '以路由方式展示任意位置的自定义浮层',
          child: ElevatedButton(
            onPressed: () => PopRoute.showPop(
              context: context,
              left: 40,
              top: 120,
              child: Container(
                width: 180,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('自定义浮层',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('点击浮层任意位置即可关闭'),
                  ],
                ),
              ),
            ),
            child: const Text('显示浮层'),
          ),
        ),
        ShowcaseSection(
          title: 'MousePopupButton 右键菜单',
          description: '桌面端鼠标右键、移动端长按触发',
          child: MousePopupButton<String>(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: const Text(
                '右键或长按这里',
                textAlign: TextAlign.center,
              ),
            ),
            itemBuilder: (context) => const [
              PopupMenuItem<String>(value: 'copy', child: Text('复制')),
              PopupMenuItem<String>(value: 'rename', child: Text('重命名')),
              PopupMenuItem<String>(value: 'delete', child: Text('删除')),
            ],
            onSelected: (value) => _showMessage('菜单选择：$value'),
          ),
        ),
        if (_selected.isNotEmpty)
          ShowcaseSection(
            title: '最近操作',
            child: Text(_selected),
          ),
      ],
    );
  }
}