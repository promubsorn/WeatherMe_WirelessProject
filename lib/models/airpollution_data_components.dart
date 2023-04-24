class AirPollutionDataComponents {
  // final AirPollution airpollution;
  // AirPollutionDataComponents({required this.airpollution});

  // factory AirPollutionDataComponents.fromJson(Map<String, dynamic> json) =>
  //     AirPollutionDataComponents(
  //         airpollution: AirPollution.fromJson(json['list']!));

  final AirPollution airpollution;
  
  AirPollutionDataComponents({required this.airpollution});

  factory AirPollutionDataComponents.fromJson(Map<String, dynamic> json) =>
      AirPollutionDataComponents(
          airpollution: AirPollution.fromJson(json['components']));
}

class AirPollution {
  Coord? coord;
  List<Details>? list;

  AirPollution({this.coord, this.list});

  factory AirPollution.fromJson(Map<String, dynamic> json) => AirPollution(
        coord: json['coord'] == null
            ? null
            : Coord.fromJson(json['coord'] as Map<String, dynamic>),
        list: (json['list'] as List<dynamic>?)
            ?.map((e) => Details.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'coord': coord?.toJson(),
        'list': list?.map((e) => e.toJson()).toList(),
      };
}

class Coord {
  int? lon;
  int? lat;

  Coord({this.lon, this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json['lon'] as int?,
        lat: json['lat'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'lon': lon,
        'lat': lat,
      };
}

class Details {
  Main? main;
  Components? components;
  int? dt;

  Details({this.main, this.components, this.dt});

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        main: json['main'] == null
            ? null
            : Main.fromJson(json['main'] as Map<String, dynamic>),
        components: json['components'] == null
            ? null
            : Components.fromJson(json['components'] as Map<String, dynamic>),
        dt: json['dt'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'main': main?.toJson(),
        'components': components?.toJson(),
        'dt': dt,
      };
}

class Main {
  int? aqi;

  Main({this.aqi});

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        aqi: json['aqi'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'aqi': aqi,
      };
}

class Components {
  double? co;
  double? no;
  double? no2;
  double? o3;
  double? so2;
  double? pm25;
  double? pm10;
  double? nh3;

  Components({
    this.co,
    this.no,
    this.no2,
    this.o3,
    this.so2,
    this.pm25,
    this.pm10,
    this.nh3,
  });

  factory Components.fromJson(Map<String, dynamic> json) => Components(
        co: (json['co'] as num?)?.toDouble(),
        no: (json['no'] as num?)?.toDouble(),
        no2: (json['no2'] as num?)?.toDouble(),
        o3: (json['o3'] as num?)?.toDouble(),
        so2: (json['so2'] as num?)?.toDouble(),
        pm25: (json['pm2_5'] as num?)?.toDouble(),
        pm10: (json['pm10'] as num?)?.toDouble(),
        nh3: (json['nh3'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'co': co,
        'no': no,
        'no2': no2,
        'o3': o3,
        'so2': so2,
        'pm2_5': pm25,
        'pm10': pm10,
        'nh3': nh3,
      };
}
