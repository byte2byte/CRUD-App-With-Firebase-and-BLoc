import 'package:flutter/material.dart';
import 'data_bloc.dart';
import 'data_bloc_provider.dart';
export 'data_bloc.dart';

class DataBlocProvider extends InheritedWidget {
  final bloc = DataBloc();

  DataBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static DataBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(DataBlocProvider)
            as DataBlocProvider)
        .bloc;
  }
}
