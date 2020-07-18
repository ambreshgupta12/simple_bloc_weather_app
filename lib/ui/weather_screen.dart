import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/bloc/builder/builder.dart';
import 'package:weatherapp/bloc/weather_bloc/weather_bloc.dart';
import 'package:weatherapp/model/weather_response.dart';
class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var cityController = TextEditingController();
  final weatherBloc = WeatherBloc();
  bool isButtonClicked=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
                child: Container(
                  child: FlareActor(
                    "assets/worldspinner.flr",
                    fit: BoxFit.contain,
                    animation: "roll",
                  ),
                  height: 200,
                  width: 200,
                )),
            isButtonClicked? ApiStreamBuilder<WeatherResponse>(
                apiDataWidget: (WeatherResponse weatherResponse){
                  return showWeather(weatherResponse,isButtonClicked);
                },
                loadingWidget: (String message){
                  return Center(child: CircularProgressIndicator());
                },
                errorWidget: (String message){
                  return Container(
                    padding: EdgeInsets.only(right: 32, left: 32, top: 10),
                    child: Column(
                      children: <Widget>[
                        Text("${message}",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w600)),
                        SizedBox(height: 20,),
                        againSearchButtonWidget(isButtonClicked)
                      ],
                    ),
                  );
                },
                stream: weatherBloc.apiDataStream):SizedBox(),
            !isButtonClicked?Container(
              padding: EdgeInsets.only(
                left: 32,
                right: 32,
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    "Search Weather",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70),
                  ),
                  Text(
                    "Instanly",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w200,
                        color: Colors.white70),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: cityController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white70,
                      ),

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: Colors.white70, style: BorderStyle.solid)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: Colors.blue, style: BorderStyle.solid)),
                      hintText: "City Name",
                      hintStyle: TextStyle(color: Colors.white70),
                    ),
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      onPressed: (){
                        isButtonClicked=true;
                        setState(() {
                        });
                        weatherBloc.getWeather(cityController.text);
                        cityController.text='';

                      },
                      color: Colors.lightBlue,
                      child: Text("Search", style: TextStyle(color: Colors.white70, fontSize: 16),),
                    ),
                  )
                ],
              ),

            ):SizedBox(),
          ],
        ),
      ),
    );
  }
  Widget showWeather(WeatherResponse weather,bool isAgainSearching){
    return  Container(
      padding: EdgeInsets.only(right: 32, left: 32, top: 10),
      child: Column(
        children: <Widget>[
        Text(weather.name,style: TextStyle(color: Colors.white70, fontSize: 30, fontWeight: FontWeight.bold),),
      SizedBox(height: 10,),
      Text(weather.main.getTemp.round().toString()+"C",style: TextStyle(color: Colors.white70, fontSize: 50),),
      Text("Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(weather.main.getMinTemp.round().toString()+"C",style: TextStyle(color: Colors.white70, fontSize: 30),),
              Text("Min Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),
            ],
          ),
          Column(
            children: <Widget>[
              Text(weather.main.getMaxTemp.round().toString()+"C",style: TextStyle(color: Colors.white70, fontSize: 30),),
              Text("Max Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),
            ],
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
          againSearchButtonWidget(isAgainSearching)
      ],
    )
    );
  }

  Widget againSearchButtonWidget(bool isAgainSearching){
    return isAgainSearching?Container(
      width: double.infinity,
      height: 50,
      child: FlatButton(
        shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        onPressed: (){
          isButtonClicked=false;
          setState(() {
          });
        },
        color: Colors.lightBlue,
        child: Text("Again Search", style: TextStyle(color: Colors.white70, fontSize: 16),),

      ),
    ):SizedBox();
  }
}


class SearchWidget extends StatelessWidget {
  ValueChanged<bool> isAgainSearch;
  SearchWidget({this.isAgainSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: FlatButton(
        shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        onPressed: (){
          isAgainSearch(true);
        },
        color: Colors.lightBlue,
        child: Text("Again Search", style: TextStyle(color: Colors.white70, fontSize: 16),),

      ),
    );
  }
}
