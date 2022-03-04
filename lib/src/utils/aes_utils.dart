
import 'package:encrypt/encrypt.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 5/14/21.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
/// 
/// 代码清单 
///代码清单

class EncryptUtils {
  //AES加密
  static aesEncrypt(String plainText, String keyStr, String ivStr) {
    try {
      final key = Key.fromUtf8(keyStr);
      final iv = IV.fromUtf8(ivStr);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      return encrypted.base64;
    } catch (err) {
      print("aes encode error:$err");
      return plainText;
    }
  }

  //AES解密
  static dynamic aesDecrypt(encrypted, String keyStr, String ivStr) {
    try {
      final key = Key.fromUtf8(keyStr);
      final iv = IV.fromUtf8(ivStr);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final decrypted = encrypter.decrypt64(encrypted, iv: iv);
      return decrypted;
    } catch (err) {
      print("aes decode error:$err");
      return encrypted;
    }
  }
}