import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';

 class EncryptionDecryption{

  //  static final key = encrypt.Key.fromUtf8("my32lengthsupersecretnooneknows1");
  //  static final iv = encrypt.IV.fromLength(16);
  //

   static final key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1');
   static final iv = encrypt.IV.fromUtf8('1234567890123456');

   static final encrypter = encrypt.Encrypter(encrypt.AES(key));

   static encryptAES(text) {
     final encrypted = encrypter.encrypt(text, iv: iv);
      print(encrypted.base64);
     // print('Encrypted: ${base64.encode(encrypted.bytes)}');
     // return base64.encode(encrypted.bytes);
   }

   static decryptAES(text) {
     // final encryptedText = encrypt.Encrypted.fromUtf8(text);


     final decryptedText = encrypter.decrypt(text);
     print(decryptedText);
     // print('Decrypted: $decryptedText');
     // return decryptedText;
   }



  // Encryption
  // final plainText = 'mohamed';
  // final encryptedText = encrypter.encrypt(plainText, iv: iv);


  // Decryption

}
