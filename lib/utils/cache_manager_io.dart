import 'dart:io';

///
/// author:郑再红
/// email:1096877329@qq.com
/// date: 2021/6/14
/// time: 16:10
/// describe: 缓存工具 - IO 平台实现
///
class CacheManagerImpl {
  CacheManagerImpl._();

  ///获取当前文件大小
  static Future<double> getTotalSizeOfFilesInDir(
      final FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      double total = 0;
      for (final FileSystemEntity child in children) {
        total += await getTotalSizeOfFilesInDir(child);
      }
      return total;
    }
    return 0;
  }

  ///  外部可借助 path_provider 获取指定的目录读取大小
  ///  Directory docDirectory = await getApplicationDocumentsDirectory();
  ///  Directory tempDirectory = await getTemporaryDirectory();
  static Future<double> loadApplicationCache({dynamic docDirectory, dynamic tempDirectory}) async {
    double size = 0;
    if (null != docDirectory && docDirectory.existsSync()) {
      size += await getTotalSizeOfFilesInDir(docDirectory);
    }
    if (null != tempDirectory && tempDirectory.existsSync()) {
      size += await getTotalSizeOfFilesInDir(tempDirectory);
    }
    return size;
  }

  static Future<void> deleteDirectory(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await deleteDirectory(child);
        await child.delete();
      }
    }
  }

  /// 删除缓存
  static void clearApplicationCache({dynamic docDirectory, dynamic tempDirectory}) async {
    if (null != docDirectory && docDirectory.existsSync()) {
      await deleteDirectory(docDirectory);
    }

    if (null != tempDirectory && tempDirectory.existsSync()) {
      await deleteDirectory(tempDirectory);
    }
  }

  /// 将数据内容写入doc文件夹里，如果不传direcName，默认存doc文件夹
  /// documentsDir 文件夹 ---路径。没有则创建
  /// fileName: 文件名
  /// notes 要存储的内容
  /// direcName 文件夹名字，如分类，首页，购物车，我的等。可不传
  /// userId 可根据不同的用创建不同的文件夹 简单标示
  static Future<File> writeToFile(
      dynamic documentsDir,
      String fileName,
      String notes,
      {String? direcName, String? userId = "user"}) async {
    if (!documentsDir.existsSync()) {
      documentsDir.createSync();
    }

    String userFileDirec = '${documentsDir.path}/$userId';
    documentsDir = Directory(userFileDirec);
    if (!documentsDir.existsSync()) {
      documentsDir.createSync();
    }

    //功能文件夹
    if (direcName != null) {
      String path = '${documentsDir.path}/$direcName';
      documentsDir = Directory(path);
    }
    if (!documentsDir.existsSync()) {
      documentsDir.createSync();
    }
    String documentsPath = documentsDir.path;
    File file = File('$documentsPath/$fileName');
    if (!file.existsSync()) {
      file.createSync();
    }

    //写入文件
    return file.writeAsString(notes);
  }
}
