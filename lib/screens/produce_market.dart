import 'package:farming_app/screens/produce_screen.dart';
import 'package:flutter/material.dart';
import 'package:farming_app/data_storage.dart';

class ProduceMarket extends StatefulWidget {
  @override
  _ProduceMarketState createState() => _ProduceMarketState();
}

class _ProduceMarketState extends State<ProduceMarket> {

  Database db = new Database();

  @override
  Widget build(BuildContext context) {
    return db.dataPost(true);
  }
}
