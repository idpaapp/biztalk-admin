
class Helper {

  static String formatDate(String date) {

    var dates = date.split('/');
    String result = dates[0];
    if (int.parse(dates[1]) < 10){
      result += '/0${dates[1]}';
    }else {
      result += '/${dates[1]}';
    }

    if (int.parse(dates[2]) < 10){
      result += '/0${dates[2]}';
    }else {
      result += '/${dates[2]}';
    }

    return result;
  }

}