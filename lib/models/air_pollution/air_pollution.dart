import 'coord.dart';
import 'details.dart';

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
