class Helpers {
  static bool boolVal(int? v) {
    return v != 0 ? true : false;
  }

  static int intVal(bool? v) {
    return v != false ? 1 : 0;
  }

  static String formattedSentTime(String sentTime) {
    DateTime dateTime = DateTime.parse(sentTime);
    String formattedTime = '${dateTime.hour}:${dateTime.minute}';
    return formattedTime;
  }

  static String formattedSentTimeDate(String sentTime) {
    DateTime dateTime = DateTime.parse(sentTime);
    String monthAbbreviation;
    switch (dateTime.month) {
      case 1:
        monthAbbreviation = 'Jan';
        break;
      case 2:
        monthAbbreviation = 'Fév';
        break;
      case 3:
        monthAbbreviation = 'Mar';
        break;
      case 4:
        monthAbbreviation = 'Avr';
        break;
      case 5:
        monthAbbreviation = 'Mai';
        break;
      case 6:
        monthAbbreviation = 'Juin';
        break;
      case 7:
        monthAbbreviation = 'Juil';
        break;
      case 8:
        monthAbbreviation = 'Aoû';
        break;
      case 9:
        monthAbbreviation = 'Sep';
        break;
      case 10:
        monthAbbreviation = 'Oct';
        break;
      case 11:
        monthAbbreviation = 'Nov';
        break;
      case 12:
        monthAbbreviation = 'Déc';
        break;
      default:
        monthAbbreviation = '';
    }
    String formattedTime = '${dateTime.day} $monthAbbreviation';
    return formattedTime;
  }
}
