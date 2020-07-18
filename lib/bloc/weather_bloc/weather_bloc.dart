import 'package:weatherapp/bloc/base_bloc.dart';
import 'package:weatherapp/model/weather_response.dart';
import 'package:weatherapp/respository/api_respository.dart';
import 'package:weatherapp/service/handle_error.dart';

class WeatherBloc extends BaseBloc<WeatherResponse>{
  final ApiRespository apiRespository=ApiRespository();
  void getWeather(String city)async{
    startLoading('loading');
    try{
      addDataToStream(await apiRespository.getWeather(city));
    }
    catch(e){
      addErrorToStream(handleError(e));
    }
  }

}