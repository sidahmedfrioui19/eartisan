import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String apiUrl = dotenv.env['API_URL']!;
  static String defaultAvatar =
      'https://static.vecteezy.com/system/resources/previews/009/292/244/original/default-avatar-icon-of-social-media-user-vector.jpg';
  static String defaultPicture =
      'https://t3.ftcdn.net/jpg/04/31/62/50/360_F_431625054_iUKl2g6GQJFWdiXAC2dLdrsNmfBlswyQ.jpg';
}
