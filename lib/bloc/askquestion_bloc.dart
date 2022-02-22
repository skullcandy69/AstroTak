import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'askquestion_event.dart';
part 'askquestion_state.dart';

class AskquestionBloc extends Bloc<AskquestionEvent, AskquestionState> {
  AskquestionBloc() : super(AskquestionInitial()) {
    on<AskquestionEvent>((event, emit) {
   });
  }
}
