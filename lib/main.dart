import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safaristore/view/records_screen.dart';
import 'blocs/records_bloc.dart';
import 'services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App com BLoC',
      home: BlocProvider(
        create: (context) => RecordsBloc(apiService: ApiService())..add(FetchRecords()),
        child: RecordsScreen(),
      ),
    );
  }
}
