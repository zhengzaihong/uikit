import 'dart:io';
///
/// create_user: zhengzaihong
/// email:1096877329@qq.com
/// create_date: 2021/6/14
/// create_time: 16:10
/// describe: 缓存工具
///
class CacheManager {

  ///获取当前文件大小
  static Future<double> _getTotalSizeOfFilesInDir(
      final FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      double total = 0;
      for (final FileSystemEntity child in children) {
        total += await _getTotalSizeOfFilesInDir(child);
      }
      return total;
    }
    return 0;
  }

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

  static Future<String> getCache({Directory? docDirectory,Directory? tempDirectory}) async {
    var size = await loadApplicationCache(docDirectory: docDirectory,tempDirectory: tempDirectory);
    return formatSize(size);
  }

  
  ///  外部可借助 path_provider 获取指定的目录读取大小
  ///  Directory docDirectory = await getApplicationDocumentsDirectory();
  ///  Directory tempDirectory = await getTemporaryDirectory();
  static Future<double> loadApplicationCache({Directory? docDirectory,Directory? tempDirectory}) async {
    double size = 0;
    if (null!= docDirectory && docDirectory.existsSync()) {
      size += await _getTotalSizeOfFilesInDir(docDirectory);
    }
    if (null!= tempDirectory && tempDirectory.existsSync()) {
      size += await _getTotalSizeOfFilesInDir(tempDirectory);
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
  static void clearApplicationCache({Directory? docDirectory,Directory? tempDirectory}) async {

    if (null!=docDirectory && docDirectory.existsSync()) {
      await deleteDirectory(docDirectory);
    }

    if (null!=tempDirectory && tempDirectory.existsSync()) {
      await deleteDirectory(tempDirectory);
    }
  }

  /// 将数据内容写入doc文件夹里，如果不传direcName，默认存doc文件夹
  /// documentsDir 文件夹 ---路径。没有则创建
  /// fileName: 文件名
  /// notes 要存储的内容
  /// direcName 文件夹名字，如分类，首页，购物车，我的等。可不传
  /// userId 可根据不同的用创建不同的文件夹 简单标示
  static void writeToFile(
  Directory documentsDir,
      String fileName, 
      String notes,
      {String? direcName,String? userId="user"}) async {
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
    File file1 = await file.writeAsString(notes);
    if (file1.existsSync()) {
      print("保存成功");
    }
  }
}
