import 'package:equatable/equatable.dart';

class Submission extends Equatable{
  String participation_email;
  int survey;
  List<int> answer;
  Submission(
      {required this.participation_email,
      required this.survey,
      required this.answer});
  @override
  // TODO: implement props
  List<Object?> get props => [participation_email,survey,answer];
}
