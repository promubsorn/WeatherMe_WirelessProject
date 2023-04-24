import "airpollution_data_components.dart";

class AirPollutionData {
  final AirPollutionDataComponents? components;

  AirPollutionData([this.components]);

  AirPollutionDataComponents getComponents() => components!;
}
