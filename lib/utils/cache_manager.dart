///
/// author:郑再红
/// email:1096877329@qq.com
/// date: 2021/6/14
/// time: 16:10
/// describe: 缓存工具 - 支持多平台（包括 Web）
///
import 'cache_manager_io.dart'
    if (dart.library.html) 'cache_manager_web.dart';

class CacheManager {
  CacheManager._();

  //格式转换
  static String formatSize(double? value) {
    if (null == value) {
      return '0B';
    }

    List<String> unitArr = ['B', 'K', 'M', 'G'];
    int index = 0;
    while (value! > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  static Future<String> getCache({dynamic docDirectory, dynamic tempDirectory}) async {
    var size = await loadApplicationCache(docDirectory: docDirectory, tempDirectory: tempDirectory);
    return formatSize(size);
  }

  ///  外部可借助 path_provider 获取指定的目录读取大小
  ///  Directory docDirectory = await getApplicationDocumentsDirectory();
  ///  Directory tempDirectory = await getTemporaryDirectory();
  ///  注意: Web 平台不支持文件系统操作，将返回 0
  static Future<double> loadApplicationCache({dynamic docDirectory, dynamic tempDirectory}) async {
    return CacheManagerImpl.loadApplicationCache(
        docDirectory: docDirectory, tempDirectory: tempDirectory);
  }

  /// 删除缓存
  /// 注意: Web 平台不支持文件系统操作
  static void clearApplicationCache({dynamic docDirectory, dynamic tempDirectory}) async {
    CacheManagerImpl.clearApplicationCache(
        docDirectory: docDirectory, tempDirectory: tempDirectory);
  }

  /// 将数据内容写入doc文件夹里，如果不传direcName，默认存doc文件夹
  /// documentsDir 文件夹 ---路径。没有则创建
  /// fileName: 文件名
  /// notes 要存储的内容
  /// direcName 文件夹名字，如分类，首页，购物车，我的等。可不传
  /// userId 可根据不同的用创建不同的文件夹 简单标示
  /// 注意: Web 平台不支持文件系统操作，将抛出 UnsupportedError
  static Future<dynamic> writeToFile(
      dynamic documentsDir,
      String fileName,
      String notes,
      {String? direcName, String? userId = "user"}) async {
    return CacheManagerImpl.writeToFile(
        documentsDir, fileName, notes,
        direcName: direcName, userId: userId);
  }
}
