import 'package:flutter/material.dart';

class Helpers {
  static Text membersText(List<String> members) {
    String membersString = "";
    for (String member in members) {
      membersString += ("$member, ");
    }
    return Text(membersString);
  }
}