class Weather{
  final String cityNAme;
  final double temperature;
  final String mainCondition;

  Weather({

    required this.cityNAme,
    required this.temperature,
    required this.mainCondition

  });

  factory Weather.fromJson(Map<String, dynamic> json){
    return Weather(
      cityNAme: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
    );
  }
}