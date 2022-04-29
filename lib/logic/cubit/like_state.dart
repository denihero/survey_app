part of 'like_cubit.dart';

abstract class LikeState extends Equatable {
  final bool hasReachedMax;
  final Map<Surveys, int> favorites;
  const LikeState(this.favorites,{this.hasReachedMax=false});
  // factory LikeState.fromJson(List map) {
  //   return LikeSuccess(map.map((e) => Like.fromMap(e)).toList());
  // }

  @override
  List<Object> get props => [favorites,hasReachedMax];
}

class LikeInitial extends LikeState {
  LikeInitial() : super({});
}

class LikeLoading extends LikeState {
  LikeLoading() : super({});
}

class LikeError extends LikeState {
  LikeError() : super({});
}

class LikeSuccess extends LikeState {
  const LikeSuccess(Map<Surveys, int> favorites,{has=false}) : super(favorites,hasReachedMax: has);
  @override
  String toString() {
    return "$favorites";
  }
}

class LikeEmpty extends LikeState {
  LikeEmpty() : super({});
}

class Like extends Equatable {
  int id;
  int survey;
  Like(this.id, this.survey);

  Like copyWith({
    int? id,
    int? survey,
  }) {
    return Like(
      id ?? this.id,
      survey ?? this.survey,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'survey': survey,
    };
  }

  factory Like.fromMap(Map<String, dynamic> map) {
    return Like(
      map['id'],
      map['survey'],
    );
  }
  String toJson() => json.encode(toMap());
  factory Like.fromJson(String source) => Like.fromMap(json.decode(source));
  @override
  // TODO: implement props
  List<Object?> get props => [id];
  @override
  String toString() {
    // TODO: implement toString
    return "$survey";
  }
}
