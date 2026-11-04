///
/// author:郑再红
/// email:1096877329@qq.com
/// date: 2021/6/14
/// time: 16:10
/// describe: 缓存工具 - Web 平台实现
///
class CacheManagerImpl {
  CacheManagerImpl._();

  ///获取当前文件大小
  static Future<double> getTotalSizeOfFilesInDir(dynamic file) async {
    // Web 平台不支持文件系统操作
    return 0;
  }

  ///  Web 平台使用浏览器存储，不支持文件系统
  static Future<double> loadApplicationCache({dynamic docDirectory, dynamic tempDirectory}) async {
    // Web 平台不支持文件系统操作
    return 0;
  }

  static Future<void> deleteDirectory(dynamic file) async {
    // Web 平台不支持文件系统操作
  }

  /// 删除缓存
  static void clearApplicationCache({dynamic docDirectory, dynamic tempDirectory}) async {
    // Web 平台不支持文件系统操作
  }

  /// Web 平台不支持文件系统写入
  static Future<dynamic> writeToFile(
      dynamic documentsDir,
      String fileName,
      String notes,
      {String? direcName, String? userId = "user"}) async {
    throw UnsupportedError('File operations are not supported on web platform. Use browser storage APIs instead.');
  }
}
