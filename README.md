# uikit

Language: English | [简体中文](README-ZH.md)


A fully **Dart-based** cross-platform **Flutter UI component library**, supporting compilation to **HarmonyOS (SDK ≥ 3.29)**. It provides high-quality, extensible UI components to make your project development more efficient!

---

## 🌟 Highlights
- 📦 Rich UI components: input fields, pickers, tables, menus, animation effects, etc.
- 🔗 **Zero dependencies**, fully implemented in Dart, ready to use out of the box.
- 🎨 Highly customizable, supporting style extensions and secondary encapsulation.
- 🌍 Multi-platform support: **Android / iOS / Web / Windows / MacOS / Linux / HarmonyOS**
- 🔥 Continuously updated, already providing **20+ commonly used components**

---

## 📦 Installation
Add dependency in `pubspec.yaml`:
```yaml
dependencies:
  uikit_plus: ^0.4.0   //The old version is not maintained, and the old version last relies on the address： flutter_uikit_forzzh:0.3.1
```


# 📚 Component Catalog

- LinearProgressBar/CycleProgressBar: Progress bar components (linear and circular)
- RatingBar: Rating component
- Toast: Fully customizable toast component (supports style customization, fixed position, queue, etc.)
- CityPickerView：CityPickerView: City picker
- DatePicker：DatePicker: Date picker
- TimeView：TimeView: Countdown under any widget
- TableView：TableView: Table layout supporting both horizontal and vertical scrolling
- MarqueeView： MarqueeView: Marquee component
- InfiniteLevelsMenus： InfiniteLevelsMenus: Infinite-level menus with simplified logic
- InputText： InputText: Minimal input field, supports real-time form validation, all TextField and TextFormField properties, and linked popups.
- FloatExpendButton： (Up, down, left, right) Retractable menu buttons
- InputExtend：Enter the search component, which supports all properties of TextField in Flutter
- Pager：Pager: Pagination component
- SelectionMenu：SelectionMenu: Dropdown menu without concern for data itself
- SelectionMenuForm： SelectionMenuForm: Dropdown with real-time selection validation
- TextExtend： TextExtend: Text extension component, supports web-style JS menu effects and elastic animations
- MousePopupButton： MousePopupButton: Right-click popup component for web
- Shimmer： Shimmer: Shimmer loading effect
- ImageSwitch： ImageSwitch: Highly customizable switch button component
- KitSwitch：KitSwitch: Switch component supporting Android and iOS
- KitCheckBox：KitCheckBox: Simplified checkbox component
- ZTooltip： ZTooltip: Tooltip component for any widget
- Radar5DimensionsChart/RadarChart：Radar5DimensionsChart/RadarChart: 5D and ND radar components
- CustomAnimatedBottomBar： CustomAnimatedBottomBar: Bottom animated menu
- StackCard：StackCard: Stacked card component
- MultiSelector：MultiSelector: Infinite-level collapsible menu
- DrawerRouterStack: Component for implementing multi-level sub-drawers or peer content routing inside drawers (to be used with DrawerRouter)

  ...continuously updating....



## 🎨 Component Showcase --- See source code for more examples


### Common Widgets:
![](https://github.com/zhengzaihong/uikit/blob/master/images/widgets1.gif)

### Radar Components (5-N Dimensions):
![radar](https://github.com/zhengzaihong/uikit/blob/master/images/radar-n.png )
![radar](https://github.com/zhengzaihong/uikit/blob/master/images/radar-n2.png)


### Date Components:
![](https://github.com/zhengzaihong/uikit/blob/master/images/date_picker.gif)


### Minimal Input Field supports all TextField and TextFormField properties, with real-time validation
![](https://github.com/zhengzaihong/uikit/blob/master/images/input_text.gif)
![](https://github.com/zhengzaihong/uikit/blob/master/images/input_text_pop.gif)


### Bottom Navigation Menu:
![CustomAnimatedBottomBar](https://github.com/zhengzaihong/uikit/blob/master/images/bottom_bar.gif) )

### Input Field Extension with Search:

![](https://github.com/zhengzaihong/uikit/blob/master/images/inputextentd.gif)

### City Picker:
![](https://github.com/zhengzaihong/uikit/blob/master/images/citypicker.gif)


### Customizable Toast:
![](https://github.com/zhengzaihong/uikit/blob/master/images/toast.gif)
![](https://github.com/zhengzaihong/uikit/blob/master/images/toast_point.png)
![](https://github.com/zhengzaihong/uikit/blob/master/images/toast_queue.gif)

### Shimmer: Shimmer loading effect：
![](https://github.com/zhengzaihong/uikit/blob/master/images/shimmer1.gif)



### Customizable Tooltip:
![](https://github.com/zhengzaihong/uikit/blob/master/images/ztooltip.gif)


### Highly Customizable Dropdown Menu:
![](https://github.com/zhengzaihong/uikit/blob/master/images/SelectionMenu2.jpg)

### Infinite-Level Menu
![](https://github.com/zhengzaihong/uikit/blob/master/images/one_expand.gif)
### Infinite-Level Multi-Select Menu!
![](https://github.com/zhengzaihong/uikit/blob/master/images/selector.png)

### Table Component
![](https://github.com/zhengzaihong/uikit/blob/master/images/table_scroller.gif)

### Pagination Component
![](https://github.com/zhengzaihong/uikit/blob/master/images/pager_image.png)



    Copyright (c) 2018 ZhengZaiHong
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.