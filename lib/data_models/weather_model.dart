class WeatherModel {
  Map<String, dynamic> main;
  List<dynamic> weather;
  Map<String, dynamic> clouds;
  Map<String, dynamic> wind;
  String dt_txt;

  WeatherModel({
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.dt_txt,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        main: json["main"],
        weather: json["weather"],
        clouds: json["clouds"],
        wind: json["wind"],
        dt_txt: json['dt_txt']);
  }

  factory WeatherModel.fromJsonForGruping(Map<String, dynamic> json) {
    var parse_date = DateTime.parse(json['dt_txt']);
    var day = parse_date.day.toString();
    return WeatherModel(
      main: json["main"],
      weather: json["weather"],
      clouds: json["clouds"],
      wind: json["wind"],
      dt_txt: day,
    );
  }
}
