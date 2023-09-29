class Finance {
  int? _id;
  String? _date;
  String? _amount;
  String? _description;
  String? _type;

  int? get id => _id;

  String? get date => _date;
  set date(String? value) => _date = value;

  String? get amount => _amount;
  set amount(String? value) => _amount = value;

  String? get description => _description;
  set description(String? value) => _description = value;

  String? get type => _type;
  set type(String? value) => _type = value;

  // konstruktor versi 1
  Finance(this._date, this._amount, this._description,this._type);

  // konstruktor versi 2: konversi dari Map ke Item
  Finance.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _date = map['date'];
    _amount = map['amount'];
    _description = map['description'];
    _type = map['type'];
  }

  // konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = date;
    map['amount'] = amount;
    map['description'] = description;
    map['type'] = type;
    return map;
  }
}
