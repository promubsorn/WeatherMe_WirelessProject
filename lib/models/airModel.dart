import 'dart:ffi';

class AirModel {
  List<double>? coord;
  List<Details>? list;

  AirModel({this.coord, this.list});

  AirModel.fromJson(Map<String, dynamic> json) {
    // coord = json['coord'].cast<double>();
    if (json['list'] != null) {
      list = <Details>[];
      json['list'].forEach((v) {
        list!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coord'] = this.coord;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  int? dt;
  Main? main;
  Components? components;

  Details({this.dt, this.main, this.components});

  Details.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    components = json['components'] != null
        ? new Components.fromJson(json['components'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    if (this.main != null) {
      data['main'] = this.main!.toJson();
    }
    if (this.components != null) {
      data['components'] = this.components!.toJson();
    }
    return data;
  }
}

class Main {
  int? aqi;

  Main({this.aqi});

  Main.fromJson(Map<String, dynamic> json) {
    aqi = json['aqi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aqi'] = this.aqi;
    return data;
  }
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

  Components(
      {this.co,
      this.no,
      this.no2,
      this.o3,
      this.so2,
      this.pm25,
      this.pm10,
      this.nh3});

  Components.fromJson(Map<String, dynamic> json) {
    co = json['co'];
    no = json['no'];
    no2 = json['no2'];
    o3 = json['o3'];
    so2 = json['so2'];
    pm25 = json['pm2_5'];
    pm10 = json['pm10'];
    nh3 = json['nh3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['co'] = this.co;
    data['no'] = this.no;
    data['no2'] = this.no2;
    data['o3'] = this.o3;
    data['so2'] = this.so2;
    data['pm2_5'] = this.pm25;
    data['pm10'] = this.pm10;
    data['nh3'] = this.nh3;
    return data;
  }
}
