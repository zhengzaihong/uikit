import 'dart:async';
import 'package:flutter/material.dart';

///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2025/2/6
/// create_time: 15:26
/// describe: 基于 flutter_router_forzzh 路由
/// 需配合 DrawerRouterStack 组件使用实现抽屉路由栈，使用请先绑定正确的 context
/// bindDrawerNavigatorContext(),通常为 Scaffold 子组件的上下文，非根 context
/// 针对抽屉中包含很多同层级或子层级的抽屉的解决方案 通常用于 Web端
///
/// eg:
//      final drawerRouter = DrawerRouter.getInstance();
//
//        Scaffold(
//          endDrawer:DrawerRouterStack(
//           listenable: drawerRouter,
//           bind: (context)=>drawerRouter.bindDrawerNavigatorContext(context),
//           builder: (context, child) {
//             return SmartDrawer(
//               width: 780,
//               child: drawerRouter.getCurrentPage(),
//             );
//           },
//         ),
//         body: Text(""),
//       )

class DrawerRouter extends RouterDelegate<RouteInformation> with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteInformation> {

  Map? pageMap = {};

  String? _location;

  BuildContext? drawerNavigatorContextContext;

  final List<MaterialPage> _pages = [];

  static final _navigatorKey = GlobalKey<NavigatorState>();

  DrawerRouter._({
    this.pageMap,
  }) : super() {
    pageMap?.forEach((key, value) {
      _pages.add(MaterialPage(child: value));
    });
  }

  static DrawerRouter? _instance;

  static DrawerRouter getInstance({Map? pageMap}) {
    _instance ??= DrawerRouter._(pageMap: pageMap);
    return _instance!;
  }

  @override
  RouteInformation get currentConfiguration {
    return RouteInformation(uri: Uri.parse(_location ?? '/'));
  }


  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  void bindDrawerNavigatorContext(BuildContext context) {
    drawerNavigatorContextContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: _onPopInvoked,
        child: Navigator(
          key: navigatorKey,
          pages: List.of(_pages),
          onPopPage: _onPopPage,
        ));
  }
  void _onPopInvoked(bool didPop) {
    // 当 canPop 为 false 时, didPop 总是 false.
    // 我们在此处手动处理返回手势.
    if (!didPop) {
      popRoute();
    }
  }



  void pop({bool closeDrawer = false,bool endDrawer = true}) async {
    if (canPop()) {
      _pages.removeLast();
    }
    if (_pages.isEmpty && closeDrawer  && drawerNavigatorContextContext != null) {
      if(endDrawer){
        Scaffold.of(drawerNavigatorContextContext!).closeEndDrawer();
      }else{
        Scaffold.of(drawerNavigatorContextContext!).closeDrawer();
      }
    }
    notify();
  }

  @override
  Future<void> setNewRoutePath(RouteInformation configuration) async {
    return popAndPushNamed(name: configuration.uri.toString());
  }

  @override
  Future<bool> popRoute() async {
    if (Navigator.of(navigatorKey.currentContext!).canPop()) {
      Navigator.of(navigatorKey.currentContext!).pop();
      return Future.value(true);
    }
    if (canPop()) {
      _pages.removeLast();
      notify();
      return Future.value(true);
    }
    return Future.value(false);
  }

  bool canPop() => _pages.isNotEmpty;

  bool _onPopPage(Route route, dynamic result) {
    if (!route.didPop(result)) {
      return false;
    }
    if (canPop()) {
      _pages.removeLast();
      return true;
    }
    return false;
  }

  void push(
      {required Widget page,
      bool openDrawer = true,
      bool endDrawer = true,
      String? name,
      Object? arguments,
      String? restorationId}) {
    var routeSettings = RouteSettings(
        name: name ?? page.runtimeType.toString(), arguments: arguments);

    if(_pages.isEmpty && openDrawer && drawerNavigatorContextContext != null){
      if(endDrawer){
        Scaffold.of(drawerNavigatorContextContext!).openEndDrawer();
      }else{
        Scaffold.of(drawerNavigatorContextContext!).openDrawer();
      }
    }
    ///展示新界面
    _pages.add(MaterialPage(
        child: page,
        name: routeSettings.name,
        arguments: routeSettings.arguments,
        restorationId: restorationId));

    notify();
  }

  Widget getCurrentPage() {
    return (_pages.last).child;
  }

  MaterialPage getCurrentMaterialPage() {
    return (_pages.last);
  }

  void replace(
      {required Widget page,
      String? name,
      Object? arguments,
      String? restorationId}) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    push(
        page: page,
        name: name,
        arguments: arguments,
        restorationId: restorationId);
  }

  void pushNamedAndRemove(
      {required String name,
      Object? arguments,
      Widget? emptyPage,
      String? restorationId}) {
    if (_pages.isNotEmpty) {
      _pages.clear();
    }
    pushNamed(
        name: name,
        arguments: arguments,
        emptyPage: emptyPage,
        restorationId: restorationId);
  }

  void popAndPushNamed(
      {required String name, Object? arguments, Widget? emptyPage}) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    pushNamed(name: name, arguments: arguments, emptyPage: emptyPage);
  }

  void pushNamed(
      {required String name,
      Object? arguments,
      Widget? emptyPage,
      String? restorationId}) {
    var page = pageMap?[name];
    _location = name;
    if (page == null) {
      _location = '404';
      page = emptyPage ?? const Center(child: Text('404'));
    }
    push(
        page: page,
        name: name,
        arguments: arguments,
        restorationId: restorationId);
  }

  void goRootPage() {
    _pages.clear();
    _location = '/';
    pushNamed(name: _location!);
  }

  void pushAndRemoveUntil(Widget page) {
    pages.clear();
    push(page: page);
  }

  //栈顶跳转
  void pushStackTop({required Widget page}) {
    if (_pages.isNotEmpty) {
      _pages.removeWhere(
          (element) => element.child.runtimeType == page.runtimeType);
    }
    push(page: page);
  }

  List<MaterialPage> get pages => _pages;

  String? getLocation() {
    return _location;
  }

  set location(String value) {
    _location = value;
    popAndPushNamed(name: _location!);
  }

  void notify() {
    notifyListeners();
  }
}
