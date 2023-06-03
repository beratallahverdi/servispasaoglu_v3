import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:servispasaoglu_v3/models/sample_model.dart';

class SampleProvider extends ChangeNotifier {
  final List<Sample> _dataList = [];
  final String _dbKey = 'samples';
  late Box<dynamic> _db;

  List<Sample> get sampleData => _dataList;

  // Constructor
  SampleProvider(Box<dynamic> db) {
    _db = db;
    List<Sample> tmp = [];
    for (var item in _db.get(_dbKey, defaultValue: List<Sample>.empty())) {
      tmp.add(item);
    }
    addAll(tmp);
  }

  // create
  void add(Sample item) {
    _dataList.add(item);
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void addAll(List<Sample> items) {
    _dataList.addAll(items);
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void clear() {
    _dataList.clear();
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void remove(Sample item) {
    _dataList.remove(item);
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void removeAll(List<Sample> items) {
    _dataList.removeWhere((item) => items.contains(item));
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void removeAt(int index) {
    _dataList.removeAt(index);
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void removeRange(int start, int end) {
    _dataList.removeRange(start, end);
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void removeWhere(bool Function(Sample element) test) {
    _dataList.removeWhere(test);
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void retainWhere(bool Function(Sample element) test) {
    _dataList.retainWhere(test);
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void sort([int Function(Sample a, Sample b)? compare]) {
    _dataList.sort(compare);
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void shuffle([Random? random]) {
    _dataList.shuffle(random);
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void insert(int index, Sample item) {
    _dataList.insert(index, item);
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void insertAll(int index, Iterable<Sample> iterable) {
    _dataList.insertAll(index, iterable);
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void setAll(int index, Iterable<Sample> iterable) {
    _dataList.setAll(index, iterable);
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void replaceRange(int start, int end, Iterable<Sample> newContents) {
    _dataList.replaceRange(start, end, newContents);
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void fillRange(int start, int end, [Sample? fillValue]) {
    _dataList.fillRange(start, end, fillValue);
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void setRange(int start, int end, Iterable<Sample> iterable,
      [int skipCount = 0]) {
    _dataList.setRange(start, end, iterable, skipCount);
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void removeLast() {
    _dataList.removeLast();
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void sortDescending() {
    _dataList.sort((a, b) => b.id.compareTo(a.id));
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void sortAscending() {
    _dataList.sort((a, b) => a.id.compareTo(b.id));
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void update(Sample item) {
    int index = _dataList.indexWhere((element) => element.id == item.id);
    _dataList[index] = item;
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void updateAll(List<Sample> items) {
    for (Sample item in items) {
      int index = _dataList.indexWhere((element) => element.id == item.id);
      _dataList[index] = item;
    }
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void updateWhere(bool Function(Sample element) test, Sample item) {
    int index = _dataList.indexWhere(test);
    _dataList[index] = item;
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void updateWhereAll(bool Function(Sample element) test, List<Sample> items) {
    for (Sample item in items) {
      int index = _dataList.indexWhere(test);
      _dataList[index] = item;
    }
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void updateAt(int index, Sample item) {
    _dataList[index] = item;
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void updateAtAll(int index, List<Sample> items) {
    for (Sample item in items) {
      _dataList[index] = item;
    }
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void updateRange(int start, int end, Iterable<Sample> newContents) {
    _dataList.replaceRange(start, end, newContents);
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }

  void updateRangeAll(int start, int end, List<Sample> items) {
    for (Sample item in items) {
      _dataList.replaceRange(start, end, [item]);
    }
    _db.put(_dbKey, _dataList);
    notifyListeners();
  }
}
