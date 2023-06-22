class CardModel {
  int cardId;
  String nameOnCard;
  String cardNo;
  int csvNo;
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
