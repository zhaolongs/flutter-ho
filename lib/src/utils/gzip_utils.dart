import 'dart:convert';

import 'package:archive/archive.dart';

class GzipUtils {
  ///GZIP 压缩
  static String gzipEncode(String str) {
    //先来转换一下
    List<int> stringBytes = utf8.encode(str);
    //然后使用 gzip 压缩
    List<int>? gzipBytes = new GZipEncoder().encode(stringBytes);
    //然后再编码一下进行网络传输
    String compressedString = base64UrlEncode(gzipBytes!);
    return compressedString;
  }

  ///GZIP 解压缩
  static String gzipDencode(String str) {
    //先来解码一下
    List<int> stringBytes = base64Url.decode(str);
    //然后使用 gzip 压缩
    List<int> gzipBytes = new GZipDecoder().decodeBytes(stringBytes);
    //然后再编码一下
    String compressedString = utf8.decode(gzipBytes);
    return compressedString;
  }
}
