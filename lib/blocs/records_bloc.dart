import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safaristore/services/api_service.dart';

// Event Class
abstract class RecordsEvent {}

class FetchRecords extends RecordsEvent {}

// State Class
abstract class RecordsState {}

class RecordsInitial extends RecordsState {}

class RecordsLoading extends RecordsState {}

class RecordsLoaded extends RecordsState {
  final List<dynamic> records;

  RecordsLoaded(this.records);
}

class RecordsError extends RecordsState {
  final String message;

  RecordsError(this.message);
}

// BLoC Class
class RecordsBloc extends Bloc<RecordsEvent, RecordsState> {
  final ApiService apiService;

  RecordsBloc({required this.apiService}) : super(RecordsInitial()) {
    on<FetchRecords>((event, emit) async {
      emit(RecordsLoading());
      try {
        final records = await apiService.fetchRecords();
        emit(RecordsLoaded(records));
      } catch (e) {
        emit(RecordsError("Failed to fetch records: $e"));
      }
    });
  }
}
