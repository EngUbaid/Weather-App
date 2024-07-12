const String currentweatherlink =
    "https://api.openweathermap.org/data/2.5/weather?lat=34.77487611215228&lon=72.36384543277453&appid=1d1ce2a6d18eb194070b839f97b1641e&units=metric";
const String daysweatherlink =
    "api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&appid={API key}";
const hourlyweatherlink =
    "https://api.openweathermap.org/data/2.5/forecast?lat=34.77487611215228&lon=72.36384543277453&appid=1d1ce2a6d18eb194070b839f97b1641e&units=metric";
const apikey = "1d1ce2a6d18eb194070b839f97b1641e";
const lattitude = "35.3833";
const longitude = "72.1833";

currentweatherapilink(lat, lon) {
  return "https://api.openweathermap.org/data/2.5/weather?lat=$lat &lon=$lon &appid=1d1ce2a6d18eb194070b839f97b1641e&units=metric";
}

hourlyweatherapilink(lat, lon) {
  return "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=1d1ce2a6d18eb194070b839f97b1641e&units=metric";
}

weeklyweatherlink(lat, lon) {
  return "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon &appid=1d1ce2a6d18eb194070b839f97b1641e&units=metric&exclude=minutely";
}
