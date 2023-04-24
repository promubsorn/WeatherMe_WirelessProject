import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/api/api_key.dart';

class ForecastTileProvider implements TileProvider {
  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    Uint8List tileBytes = Uint8List(0);

    try {
      final url =
          "https://tile.openweathermap.org/map/precipitation_new/$zoom/$x/$y.png?appid=$apiKey&opacity=0.3&palatte=0:E1C86400;0.1:C8963200;0.2:9696AA00;0.5:7878BE00;1:6E6ECD4C;10:5050E1B2;140:1414FFE5";
      final uri = Uri.parse(url);
      final ImageData = await NetworkAssetBundle(uri).load("");
      tileBytes = ImageData.buffer.asUint8List();
    } catch (e) {
      print(e.toString());
    }

    return Tile(256, 256, tileBytes);
  }
}

class ForecastTileProviderTemp implements TileProvider {
  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    Uint8List tileBytes = Uint8List(0);

    try {
      final url =
          "https://tile.openweathermap.org/map/temp_new/$zoom/$x/$y.png?appid=$apiKey&opacity=0.6&palatte=-65:821692;-55:821692;-45:821692;-40:821692;-30:8257db;-20:208cec;-10:20c4e8;0:23dddd;10:c2ff28;20:fff028;25:ffc228;30:fc8014&fill_bound=true";
      final uri = Uri.parse(url);
      final ImageData = await NetworkAssetBundle(uri).load("");
      tileBytes = ImageData.buffer.asUint8List();
    } catch (e) {
      print(e.toString());
    }

    return Tile(256, 256, tileBytes);
  }
}
