import 'dart:async';

class HomePageBloc {
  DateTime selectedData = DateTime.now();

  StreamController<DateTime> _dateStreamController =
      StreamController<DateTime>();

  Stream<DateTime> get dataStream => _dateStreamController.stream;

  dispose() {
    _dateStreamController.close();
  }

  void addDate() {
    selectedData = selectedData.add(Duration(days: 1));
    _dateStreamController.sink.add(selectedData);
  }

  void subtractDate() {
    selectedData = selectedData.subtract(Duration(days: 1));
    _dateStreamController.sink.add(selectedData);
  }
}
