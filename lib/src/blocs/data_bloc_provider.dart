import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestore_bloc_app/models/data.dart';

import 'package:crud_firestore_bloc_app/utilities/strings.dart';
import 'package:crud_firestore_bloc_app/resources/repository.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class DataBloc {
  final _repository = Repository();
  final _title = BehaviorSubject<String>();
  final _number = BehaviorSubject<String>();
  final _addr = BehaviorSubject<String>();
  final _showProgress = BehaviorSubject<bool>();

  Stream<String> get name => _title.stream.transform(_validateName);

  Stream<String> get number => _number.stream.transform(_validateNumber);

  Stream<String> get addr => _addr.stream.transform(_validateMessage);

  ValueStream<bool> get showProgress => _showProgress.stream;

  Function(String) get changeName => _title.sink.add;

  Function(String) get changeNumber => _number.sink.add;

  Function(String) get changeaddr => _addr.sink.add;

  final _validateMessage =
      StreamTransformer<String, String>.fromHandlers(handleData: (addr, sink) {
    if (addr.length > 10) {
      sink.add(addr);
    } else {
      sink.addError(StringConstant.addrValidateMessage);
    }
  });

  final _validateName = StreamTransformer<String, String>.fromHandlers(
      handleData: (String name, sink) {
    if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(name)) {
      sink.addError(StringConstant.nameValidateMessage);
    } else {
      sink.add(name);
    }
  });

  final _validateNumber = StreamTransformer<String, String>.fromHandlers(
      handleData: (String number, sink) {
    if (RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(number)) {
      sink.addError(StringConstant.numberValidateMessage);
    } else {
      sink.add(number);
    }
  });

  void submit(String email) {
    _showProgress.sink.add(true);
    _repository
        .uploadData(email, _title.value, _addr.value, _number.value)
        .then((value) {
      _showProgress.sink.add(false);
    });
  }

  Stream<DocumentSnapshot> myDataList(String email) {
    return _repository.myDataList(email);
  }

  //dispose all open sink
  void dispose() async {
    await _addr.drain();
    _addr.close();
    await _title.drain();
    _title.close();
    await _showProgress.drain();
    _showProgress.close();
  }

  //Remove item from the goal list
  void removeData(String title, String email) {
    return _repository.removeData(title, email);
  }
}
