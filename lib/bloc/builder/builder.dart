import 'package:flutter/material.dart';
import 'package:weatherapp/service/api_response.dart';

typedef ApiDataWidget<T>=Widget Function(T);
typedef ApiValueWidget<String>= Widget Function(String);

class ApiStreamBuilder<T> extends StatelessWidget {
  final ApiDataWidget<T> apiDataWidget;
  final ApiValueWidget<String> loadingWidget;
  final ApiValueWidget<String> errorWidget;
  final Stream<ApiResponse<T>> stream;
  final bool showLoadingInitially;
  ApiStreamBuilder({
    @required this.apiDataWidget,
    @required this.loadingWidget,
    @required this.errorWidget,
    @required this.stream,
    this.showLoadingInitially=true,
  }):
        assert(apiDataWidget!=null),
        assert(loadingWidget!=null),
        assert(errorWidget!=null),
        assert(stream!=null);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse<T>>(
      initialData:showLoadingInitially?ApiResponse.loading('loading'):null,
      stream: stream,
      builder: (context, AsyncSnapshot<ApiResponse<T>> snapshot) {
        if(snapshot.hasData){
          switch(snapshot.data.status){
            case Status.Loading:
              return loadingWidget(snapshot.data.message);
            break;
            case Status.Completed:
              return apiDataWidget(snapshot.data.data);
              break;
            case Status.UnNotifiedError:
              return apiDataWidget(snapshot.data.data);
              break;
            case Status.Error:
              return errorWidget(snapshot.data.message);
              break;
          }
        }
        return Container();
      }
    );
  }
}
