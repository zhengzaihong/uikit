# uikit
[![pub package](https://img.shields.io/pub/v/uikit_plus.svg)](https://pub.dev/packages/uikit_plus)
[![GitHub stars](https://img.shields.io/github/stars/zhengzaihong/uikit.svg?style=social)](https://github.com/zhengzaihong/uikit)
[![license](https://img.shields.io/github/license/zhengzaihong/uikit)](LICENSE)


Language: [English](README.md) | 简体中文


一套完全基于 **Dart** 的跨平台 **Flutter UI 组件库**，支持编译到 **HarmonyOS (SDK ≥ 3.29)**  提供高质量、易扩展的 UI 组件，让你的项目开发更高效！

---

## 🌟 特性亮点
- 📦 丰富的 UI 组件：输入框、选择器、表格、菜单、动画效果等
- 🔗 **零依赖**，完全 Dart 实现，开箱即用
- 🎨 高度可定制，支持样式扩展与二次封装
- 🌍 多端支持：**Android / iOS / Web  /Windows / MacOS / Linux / HarmonyOS**
- 🔥 持续更新，已提供 **20+ 常用组件**

---

## 📦 安装
在 `pubspec.yaml` 中添加依赖：
```yaml
dependencies:
  uikit_plus: ^0.4.3  //旧版本不在维护，旧版本最后依赖地址：flutter_uikit_forzzh:0.3.1
```


# 📚 组件目录

## 输入与表单组件
- **InputText**: 极简输入框，支持实时校验和 TextField/TextFormField 全部属性
- **InputValidation**: 10+ 内置校验器(邮箱、手机、URL、身份证、数字等)，支持组合校验
- **InputExtend**: 搜索组件，支持 TextField 全部属性
- **KitCheckBox**: 复选框，支持三态、触觉反馈和自定义图标
- **KitSwitch**: 开关组件，支持 Android/iOS 风格和触觉反馈
- **ImageSwitch**: 高度自定义的开关按钮

## 进度与评分
- **LinearProgressBar**: 线性进度条，支持自定义颜色和动画
- **CycleProgressBar**: 圆形进度条，支持渐变色
- **RatingBar**: 评分组件，支持值格式化和自定义星星样式
- **TimeView**: 倒计时组件，支持暂停/恢复、进度追踪和自动重启

## 选择器与下拉框
- **CityPickerView**: 城市选择器，支持省市区三级联动
- **DatePicker**: 日期选择器，支持多种模式
- **SelectionMenu**: 下拉菜单，支持智能定位
- **SelectionMenuForm**: 带实时校验的下拉框
- **InfiniteLevelsMenus**: 无限层级菜单，简化使用逻辑
- **MultiSelector**: 无限层级折叠多选菜单

## 展示组件
- **Toast**: 完全自定义提示组件(样式、位置、队列支持)
- **ZTooltip**: 任意组件的提示框，支持自定义内容
- **Shimmer**: 微光加载效果
- **MarqueeView**: 跑马灯组件，支持暂停/恢复控制
- **Bubble**: 气泡组件，支持多种箭头样式
- **GlobalDialog**: 全局对话框，支持自动消失和单例管理

## 布局与导航
- **TableView**: 表格布局，支持横向和纵向滚动
- **Pager**: 分页组件，内置主题系统(4种预设主题)
- **CustomAnimatedBottomBar**: 底部导航，支持徽章显示和触觉反馈
- **StackCard**: 堆叠卡片组件，支持滑动手势
- **FloatExpendButton**: 可展开菜单按钮(上下左右)
- **DrawerRouterStack**: 多级抽屉导航
- **SmartDrawer**: 灵活的侧边栏，支持自定义宽度

## 动画与效果
- **SplashBobbleAnimation**: 飞溅气泡动画，支持自定义颜色和曲线
- **TextExtend**: 文本扩展组件，支持 Web 风格效果和弹性动画

## 图表组件
- **Radar5DimensionsChart**: 5维雷达图
- **RadarChart**: N维雷达图

  ...持续更新中....



## 🎨 组件效果展---更多效果请查看源码


### 常用小组件：
![](https://github.com/zhengzaihong/uikit/blob/master/images/widgets1.gif)

### 雷达组件 5-N维：
![radar](https://github.com/zhengzaihong/uikit/blob/master/images/radar-n.png ) 
![radar](https://github.com/zhengzaihong/uikit/blob/master/images/radar-n2.png)


### 日期组件：
![](https://github.com/zhengzaihong/uikit/blob/master/images/date_picker.gif)


### 极简输入框支持TextField 和TextFormField全部属性，支持实时表单校验
![](https://github.com/zhengzaihong/uikit/blob/master/images/input_text.gif)
![](https://github.com/zhengzaihong/uikit/blob/master/images/input_text_pop.gif)


### 底部导航菜单：
![CustomAnimatedBottomBar](https://github.com/zhengzaihong/uikit/blob/master/images/bottom_bar.gif) )

### 输入框拓展搜索组件：

![](https://github.com/zhengzaihong/uikit/blob/master/images/inputextentd.gif)

### 城市选择器：
![](https://github.com/zhengzaihong/uikit/blob/master/images/citypicker.gif)


### 可定制的Toast：
![](https://github.com/zhengzaihong/uikit/blob/master/images/toast.gif)
![](https://github.com/zhengzaihong/uikit/blob/master/images/toast_point.png)
![](https://github.com/zhengzaihong/uikit/blob/master/images/toast_queue.gif)

### 微光加载效果：
![](https://github.com/zhengzaihong/uikit/blob/master/images/shimmer1.gif)



### 可自定义样式的提示组件
![](https://github.com/zhengzaihong/uikit/blob/master/images/ztooltip.gif)


### 可高度自定义的选择下拉框组件
![](https://github.com/zhengzaihong/uikit/blob/master/images/SelectionMenu2.jpg)

### 无限层级菜单
![](https://github.com/zhengzaihong/uikit/blob/master/images/one_expand.gif)
### 无限层级多选菜单!
![](https://github.com/zhengzaihong/uikit/blob/master/images/selector.png)

### 表格组件
![](https://github.com/zhengzaihong/uikit/blob/master/images/table_scroller.gif)

### 分页组件：
![](https://github.com/zhengzaihong/uikit/blob/master/images/pager_image.png)

### 特别说明：支持编译到HarmonyOS
![](https://github.com/zhengzaihong/uikit/blob/master/images/HarmonyOS-example.gif)