import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:intl/intl.dart';
import 'package:pointycastle/asymmetric/api.dart';

String encrypt(String message) {
  final parser = RSAKeyParser();
  final publicKey = parser.parse(
          "-----BEGIN PUBLIC KEY-----\nMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAytOhlq/JPcTN0fX+VqObE5kwIaDnEtso2KGHdi9y7uTtQA6pO4fsPNJqtXOdrcfDgp/EQifPwVRZpjdbVrD6FgayrQQILAnARKzVmzwSMDdaP/hOB6i9ouKsIhN9hQUmUhbhaMkh7UXoxGW+gCSK8dq0+FJVnlt1dtJByiVAJRi2oKSdLRqNjk8yGzuZ6SrEFzAgYZwmQiywUF6V1ZaMUQDz8+nr9OOVU3c6Z2IQXCbOv6S7TAg0VhriFL18ZxUPS6759SuKC63VOOSf4EEHy1m0qBgpCzzlsB7D4ssF9x0ZVXLREFrqikP71Hg6tSGcu4YBKL+VwIDWWaXzz6szxeDXdYTA3l35P7I9uBUgMznIjTjNaAX4AXRsJcN9fpF7mVq4eK1CorBY+OOzOc+/yVBpKysdaV/yZ+ABEhX93B2kPLFSOPUKjSPK2rtqE6h2NSl5BFuGEoVBerKn+ymOnmE4/SDBSe5S6gIL5vwy5zNMsxWUaUF5XO9Ez+2v8+yPSvQydj3pw5Rlb07mAXcI18ZYGClO6g/aKL52KYnn1FZ/X3r8r/cibfDbuXC6FRfVXJmzikVUqZdTp0tOwPkh4V0R63l2RO9Luy7vG6rurANSFnUA9n842KkRtBagQeQC96dbC0ebhTj+NPmskklxr6/6Op/P7d+YY76WzvQMvnsCAwEAAQ==\n-----END PUBLIC KEY-----")
      as RSAPublicKey;

  final encrypter =
      Encrypter(RSA(publicKey: publicKey, encoding: RSAEncoding.OAEP));

  final encrypted = encrypter.encrypt(message);

  return base64Encode(encrypted.bytes);
}

String getCategoryEmoji(String category) {
  switch (category) {
    case 'Concert':
      return '🎤';
    case 'Festival':
      return '🎉';
    case 'Party':
      return '🎈';
    case 'Sport':
      return '⚽';
    case 'Seminar':
      return '📚';
    case 'Exhibition':
      return '🖼️';
    case 'Market':
      return '🛍️';
    case 'Workshop':
      return '🔧';
    default:
      return '🌍';
  }
}


String getFormattedDateTime(DateTime datetime) {
  DateFormat formatter = DateFormat('EEE, dd MMM yyyy, hh:mm a');
  return formatter.format(datetime);
}