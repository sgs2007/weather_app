class WeatherModel2 {
  Main main;
  Clouds clouds;
  Wind wind;
  String dtTxt;
  List<Weather> weather;

  WeatherModel2(
      {required this.main,
      required this.clouds,
      required this.wind,
      required this.dtTxt,
      required this.weather});

  factory WeatherModel2.fromJson(Map<String, dynamic> json) {
    var main = Main.fromJson(json["main"]);
    var clouds = Clouds.fromJson(json["clouds"]);
    var wind = Wind.fromJson(json["wind"]);
    var dtTxt = json["dt_txt"].toString();
    List<Weather> list = [];
    json["weather"].forEach((value) {
      list.add(Weather.fromJson(value));
    });
    return WeatherModel2(
        main: main, clouds: clouds, wind: wind, dtTxt: dtTxt, weather: list);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["main"] = this.main.toJson();
    data["clouds"] = this.clouds.toJson();
    data["wind"] = this.wind.toJson();
    data["dt_txt"] = this.dtTxt;
    data["weather"] = this.weather.map((value) => value.toJson()).toList();
    return data;
  }
}

class Main {
  String temp;
  String feelsLike;
  Main({required this.temp, required this.feelsLike});
  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
        temp: json["temp"].toString(),
        feelsLike: json["feels_like"].toString());
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["temp"] = this.temp;
    data["feels_like"] = this.feelsLike;
    return data;
  }
}

class Clouds {
  String all;
  Clouds({required this.all});
  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(all: json["all"].toString());
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["all"] = this.all;
    return data;
  }
}

class Wind {
  String speed;
  String deg;

  Wind({required this.speed, required this.deg});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(speed: json["speed"].toString(), deg: json['deg'].toString());
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["speed"] = this.speed;
    data["deg"] = this.deg;
    return data;
  }
}

class Weather {
  String main;
  String description;
  Weather({required this.main, required this.description});
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        main: json["main"].toString(),
        description: json["description"].toString());
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["main"] = this.main;
    data["description"] = this.description;
    return data;
  }
}
