class Climate {
  List<Weather> weather;
  Main main;
  String name;

  Climate({
    required this.weather,
    required this.main,
    required this.name,
  });
  factory Climate.initial() {
    return Climate(
      weather: [],
      main: Main(temp: 0),
      name: '',
    );
  }

  factory Climate.fromJson(Map<String, dynamic> json) => Climate(
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        main: Main.fromJson(json["main"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "main": main.toJson(),
        "name": name,
      };
}

class Main {
  double temp;

  Main({
    required this.temp,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
      };
}

class Weather {
  int id;
  String main;
  String description;

  Weather({
    required this.id,
    required this.main,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
      };
}
