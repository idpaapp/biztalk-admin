class MonthUtil {
  static final monthNames = [
    "فروردین",
    "اردیبهشت",
    "خرداد",
    "تیر",
    "مرداد",
    "شهریور",
    "مهر",
    "آبان",
    "آذر",
    "دی",
    "بهمن",
    "اسفند",
  ];

  static String getMonthName(int month) {
    int index = month - 1;
    return monthNames[index];
  }
}
