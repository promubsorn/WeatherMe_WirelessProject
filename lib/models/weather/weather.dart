// class Weather {
//   double? lat;
//   double? lon;
//   String? timezone;
//   int? timezoneOffset;
//   Current? current;
//   List<Hourly>? hourly;
//   List<Daily>? daily;

//   Weather({
//     this.lat,
//     this.lon,
//     this.timezone,
//     this.timezoneOffset,
//     this.current,
//     this.hourly,
//     this.daily,
//   });

//   factory Weather.fromJson(Map<String, dynamic> json) => Weather(
//         lat: (json['lat'] as num?)?.toDouble(),
//         lon: (json['lon'] as num?)?.toDouble(),
//         timezone: json['timezone'] as String?,
//         timezoneOffset: json['timezone_offset'] as int?,
//         current: json['current'] == null
//             ? null
//             : Current.fromJson(json['current'] as Map<String, dynamic>),
//         hourly: (json['hourly'] as List<dynamic>?)
//             ?.map((e) => Hourly.fromJson(e as Map<String, dynamic>))
//             .toList(),
//         daily: (json['daily'] as List<dynamic>?)
//             ?.map((e) => Daily.fromJson(e as Map<String, dynamic>))
//             .toList(),
//       );

//   Map<String, dynamic> toJson() => {
//         'lat': lat,
//         'lon': lon,
//         'timezone': timezone,
//         'timezone_offset': timezoneOffset,
//         'current': current?.toJson(),
//         'hourly': hourly?.map((e) => e.toJson()).toList(),
//         'daily': daily?.map((e) => e.toJson()).toList(),
//       };
// }

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json['id'] as int?,
        main: json['main'] as String?,
        description: json['description'] as String?,
        icon: json['icon'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'main': main,
        'description': description,
        'icon': icon,
      };
}
