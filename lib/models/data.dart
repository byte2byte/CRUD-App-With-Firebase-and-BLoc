class Data {
  final String _title;
  final String _address;
  final String _number;
  int _id;

  Data(this._title, this._address, this._number) {
    this._id = DateTime.now().millisecondsSinceEpoch;
  }

  String get title => _title;

  String get address => _address;

  String get number => _number;

  int get id => _id;
}
