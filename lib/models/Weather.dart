class Weather{
  final double lon;
  final double lat;
  final double precipitation_value;
  final String precipitation_units;
  final String precipitation_type;
  final DateTime observation_time;

  Weather({this.lon, this.lat, this.precipitation_value, this.precipitation_type, this.precipitation_units, this.observation_time});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      lat: json['lat'] as double,
      lon: json['lon'] as double,
      precipitation_value: json['precipitation']['value'] + 0.0 as double,
      precipitation_units: json['precipitation']['units'] as String,
      precipitation_type: json['precipitation_type']['value'] as String,
      observation_time: DateTime.parse(json['observation_time']['value']).toLocal(),
    );
  }
}