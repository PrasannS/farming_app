import 'package:flutter/material.dart';
import 'package:farming_app/data_storage.dart';

class SeedMarket extends StatefulWidget {
  @override
  _SeedMarketState createState() => _SeedMarketState();
}

class _SeedMarketState extends State<SeedMarket> {
  Database db = new Database();
  @override
  Widget build(BuildContext context) {
    return db.dataPost(false);
  }
}