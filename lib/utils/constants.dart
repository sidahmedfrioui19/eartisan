import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String apiUrl = dotenv.env['API_URL']!;
  static String defaultAvatar =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png';
  static String defaultPicture =
      'https://t3.ftcdn.net/jpg/04/31/62/50/360_F_431625054_iUKl2g6GQJFWdiXAC2dLdrsNmfBlswyQ.jpg';
}
