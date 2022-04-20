import 'package:equatable/equatable.dart';

class Submission extends Equatable {
  String participation_email;
  int survey;
  List<int> answer;
  Submission(
      {required this.participation_email,
      required this.survey,
      required this.answer});
  @override
  // TODO: implement props
  List<Object?> get props => [participation_email, survey, answer];

  Map<String, dynamic> toJson() {
    return {
      "participant_email": participation_email,
      "survey": survey,
      "answer": answer,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$participation_email $survey $answer";
  }
}

class SubmissionState extends Equatable {
  final String selectedAnswer;

  SubmissionState(this.selectedAnswer);
  @override
  // TODO: implement props
  List<Object?> get props => [selectedAnswer];
}
