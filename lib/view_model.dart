import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final viewModelProvider = ChangeNotifierProvider((ref) => ViewModel());

class Place {
  Place(this.name);

  String name;
  List<String> members = [];
  int capacity = 2;
}

class ViewModel extends ChangeNotifier {
  List<String> members = ["太郎", "花子", "二郎", "三郎"];

  List<Place> places = [Place("教室"), Place("廊下")];

  String newMember = "";
  var newMemberController = TextEditingController();

  String newPlaceName = "";
  var newPlaceNameController = TextEditingController();

  void set() {
    for (var place in places) {
      place.members = [];
    }

    List<String> members = List.of(this.members); // コピーを作る dartは参照渡しだから

    members.shuffle();

    for (var place in places) {
      while (place.members.length < place.capacity) {
        if (members.length == 0) {
          break;
        }

        place.members.add(members.last);
        members.removeLast();
      }
    }
    notifyListeners();
  }

  void addMember() {
    if (newMember == "") {
      return;
    }

    members.add(this.newMember);
    newMemberController.clear();
    newMember = "";
    notifyListeners();
  }

  void removeMember(int index) {
    members.removeAt(index);
    notifyListeners();
  }

  void addPlace() {
    if (newPlaceName == '') {
      return;
    }

    places.add(Place(newPlaceName));
    newPlaceNameController.clear();
    newPlaceName = "";
    notifyListeners();
  }

  void removePlace(int index) {
    places.removeAt(index);
    notifyListeners();
  }

  void incrementPlaceCapacity(int index) {
    places[index].capacity += 1;
    notifyListeners();
  }

  void decrementPlaceCapacity(int index) {
    if (places[index].capacity == 0) {
      return;
    }
    
    places[index].capacity -= 1;
    notifyListeners();
  }
}
