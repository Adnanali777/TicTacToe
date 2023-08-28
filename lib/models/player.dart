
class Player {
  final String nickname;
  final String playerType;
  final String socketID;
  final int points;

  Player({required this.nickname,required this.playerType, required this.socketID, required this.points});

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nickname': nickname,
      'playerType': playerType,
      'socketID': socketID,
      'points': points,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickname: map['nickname'] as String,
      playerType: map['playerType'] as String,
      socketID: map['socketID'] as String,
      points: map['points'] as int,
    );
  }

  Player copyWith({
    String? nickname,
    String? playerType,
    String? socketID,
    int? points,
  }) {
    return Player(
      nickname: nickname ?? this.nickname,
      playerType: playerType ?? this.playerType,
      socketID: socketID ?? this.socketID,
      points: points ?? this.points,
    );
  }
}
