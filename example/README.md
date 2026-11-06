# uikit_plus example

Flutter 示例工程，演示 `uikit_plus` 组件库的用法。

## 示例页面

- **基础组件**：KitSwitch、KitCheckBox、ImageSwitch、RatingBar、DashedBorder、DashedRect、SeparatorView、TextExtend、Blur、布局工具函数
- **进度条**：LinearProgressBar、CycleProgressBar
- **按钮与弹窗**：FloatExpendButton、GlobalDialog、PopRoute、MousePopupButton
- **选择与拖拽**：MultiSelector、SelectableGroup、DragBox
- **导航与动画**：CustomAnimatedBottomBar、SmartDrawer、Responsive、RotatingView、RotateView
- **数据展示**：TableExtend、Pager、RadarChart
- **表单与选择**：InputText、InputExtend、SelectionMenu、InfiniteLevelsMenus、CityPicker、DatePicker
- **反馈**：Toast、Shimmer、MarqueeView、ZTooltip、StackCard、SplashBobbleAnimation

## 运行

```bash
flutter pub get
flutter run
```

## Web 交互演示

```bash
flutter run -d chrome
# 构建静态站点
flutter build web --release --base-href /
```

在线版本（GitHub Pages）：<https://zhengzaihong.github.io/uikit/>  
发布流程由仓库根目录的 `.github/workflows/deploy-web.yml` 自动完成。

## 平台

- Android / iOS / Web / Windows / macOS / Linux
- HarmonyOS：需使用 OpenHarmony Flutter fork，并在 `ohos` 目录下构建。

示例入口：`lib/main.dart`。