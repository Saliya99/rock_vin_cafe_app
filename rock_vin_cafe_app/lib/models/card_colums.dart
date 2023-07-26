class CardModel {
  int cardId;
  String nameOnCard;
  String cardNo;
  String csvNo;
  String exp;
  String username;

  CardModel({
    required this.cardId,
    required this.nameOnCard,
    required this.cardNo,
    required this.csvNo,
    required this.exp,
    required this.username,
  });

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      cardId: int.parse(map['card_id'].toString()),
      nameOnCard: map['name_on_card'] as String,
      cardNo: map['cardno'] as String,
      csvNo: (map['csvno'] as String),
      exp: map['exp'] as String,
      username: map['username'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'card_id': cardId,
      'name_on_card': nameOnCard,
      'cardno': cardNo,
      'csvno': csvNo,
      'exp': exp,
      'username': username,
    };
  }

  List<dynamic> dataToList() {
    return [
      cardId,
      nameOnCard,
      cardNo,
      csvNo,
      exp,
      username,
    ];
  }

  String tableColumns() {
    return 'card_id, name_on_card, cardno, csvno, exp, username';
  }

  List<dynamic> dataToListoutid() {
    return [
      nameOnCard,
      cardNo,
      csvNo,
      exp,
      username,
    ];
  }

  String tableColumnsoutid() {
    return 'name_on_card, cardno, csvno, exp, username';
  }
}
