import 'package:farming_app/data_storage.dart';
import 'package:flutter/material.dart';

class ProduceMarket extends StatefulWidget {
  @override
  _ProduceMarketState createState() => _ProduceMarketState();
}

class _ProduceMarketState extends State<ProduceMarket> {

  Database data = new Database();

  @override
  Widget build(BuildContext context) {

    return data.dataPost(true);
  }
}
