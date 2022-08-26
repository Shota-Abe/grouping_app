import 'package:flutter/material.dart';

class Helpers {
  Text membersText(List<String> members) {
    String membersString = "";
    for (String member in members) {
      membersString += ("$member, ");
    }
    return Text(
      membersString,
      style: TextStyle(color: Colors.black),
    );
  }
}