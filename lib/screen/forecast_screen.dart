

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/services/weather_services.dart';


class ForecastScreen extends StatefulWidget {
  final String city;
  const ForecastScreen({super.key, required this.city});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {

  WeatherServices _weatherServices = WeatherServices();
  List<dynamic>? _forecast;

  Future<void> _fetchForecastData() async{
    try{
      final forecastData = await _weatherServices.fetch7DaysWeather(widget.city);
      setState(() {
        _forecast = forecastData['forecast']['forecastday'];
      });
    }catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchForecastData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff2d4bb0),
                Color.fromARGB(255, 194, 188, 120),
              ],
            ),
          ),
          child: _forecast == null
              ? Center(
            child: CircularProgressIndicator(color: Colors.white),
          )
              : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back, color: Colors.white, size: 30,),
                    ),
                    SizedBox(width: 20,),
                    Text(
                      "7 Days Forecast",
                      style: GoogleFonts.lato(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _forecast!.length,
                  itemBuilder: (context, index) {
                    final day = _forecast![index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Image.network(
                            'https:${day['day']['condition']['icon']}',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  day['date'],
                                  style: GoogleFonts.lato(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${day['day']['avgtemp_c']} °C',
                                      style: GoogleFonts.lato(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Max: ${day['day']['maxtemp_c']} °C',
                                          style: GoogleFonts.lato(
                                            fontSize: 16,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Min: ${day['day']['mintemp_c']} °C',
                                          style: GoogleFonts.lato(
                                            fontSize: 16,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  day['day']['condition']['text'],
                                  style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
