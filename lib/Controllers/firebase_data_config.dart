import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

Future<void> ConfigFirebaseForSongs() async {
  final String response = await rootBundle.loadString('assets/All_Songs.json');
  final data = json.decode(response);

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  for (String key in data.keys) {
    List<dynamic> songs = data[key];
    for (var song in songs) {
      await firestore.collection(key).add(song);
    }
  }

  print('Cloud Database Configured');
}