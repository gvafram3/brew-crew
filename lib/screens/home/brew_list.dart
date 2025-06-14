import 'package:brew_crew/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<QuerySnapshot?>(context);

    // Handle null or loading state
    if (brews == null) {
      return Loading();
    }

    for (var doc in brews.docs) {
      print(doc.data());
    }

    // Process the data when available
    return Container();
  }
}
