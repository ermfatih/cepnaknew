import 'package:cepnak/features/_components/future_builder_items/future_builder_widgets.dart';
import 'package:cepnak/features/_components/future_builder_items/show_error.dart';
import 'package:flutter/material.dart';

class CustomFutureBuilder<T> extends StatelessWidget {
  const CustomFutureBuilder({super.key, required this.dataWidget, required this.future, this.noDataWidget, });
  final Future<T>? future;
  final Widget Function(AsyncSnapshot<T> snapshot) dataWidget;

  final Widget? noDataWidget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return CustomCircularProgress();
        }
        if (snapshot.hasError) {
          return CustomShowError(error: snapshot.error.toString());
        }
        if(!snapshot.hasData || snapshot.data==null){
          return noDataWidget ?? SizedBox.shrink();
        }
        return dataWidget(snapshot);
      },
    );
  }
}