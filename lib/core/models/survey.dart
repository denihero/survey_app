class Surveys {
  Surveys({
    this.title,
    this.createdAt = "",
    this.updatedAt,
    this.author,
    this.category,
    this.image,
    this.questions,
    this.reviews,
  });

  String? title;
  String? createdAt;
  DateTime? updatedAt;
  String? author;
  String? category;
  String? image;
  List<Question>? questions;
  List<dynamic>? reviews;

  factory Surveys.fromJson(Map<String, dynamic> json) => Surveys(
        title: json["title"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        author: json["author"],
        category: json["category"],
        image: json["image"],
        questions: json["questions"] != null
            ? List<Question>.from(
                json["questions"].map((x) => Question.fromJson(x)))
            : [],
        reviews: json["reviews"]!=null? List<dynamic>.from(json["reviews"].map((x) => x)):[],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
        "author": author,
        "category": category,
        "image": image,
        "questions": List<dynamic>.from(questions!.map((x) => x.toJson())),
        "reviews": List<dynamic>.from(reviews!.map((x) => x)),
      };
  @override
  String toString() {
    return title??"";
  }
}

class Question {
  Question({
    this.id,
    this.text,
    this.survey,
    this.choices,
  });

  int? id;
  String? text;
  int? survey;
  List<Choice>? choices;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        text: json["text"],
        survey: json["survey"],
        choices:
            List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "survey": survey,
        "choices": List<dynamic>.from(choices!.map((x) => x.toJson())),
      };
}

class Choice {
  Choice({
    this.id,
    this.text,
    this.question,
  });

  int? id;
  String? text;
  int? question;

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        id: json["id"],
        text: json["text"],
        question: json["question"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "question": question,
      };
}
