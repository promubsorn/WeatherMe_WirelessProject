import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'components/forcast_tile_provider.dart';

class TempMap extends StatelessWidget {
  const TempMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Map'),
      ),
      body: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(13.7563, 100.5018),
    zoom: 6,
  );

  Set<TileOverlay> _tileOverlays = {};

  _initTiles() async {
    final String overlayId = DateTime.now().millisecondsSinceEpoch.toString();
    final tileOverlay = TileOverlay(
      tileOverlayId: TileOverlayId(overlayId),
      tileProvider: ForecastTileProviderTemp(),
    );
    setState(() {
      _tileOverlays = {tileOverlay};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _initTiles();
        },
        tileOverlays: _tileOverlays,
      ),
    );
  }
}
