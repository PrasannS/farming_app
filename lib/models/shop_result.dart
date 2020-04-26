import 'dart:math';

class ShopResult {
  final String url;
  final String seller;
  final String image;
  final String item;
  final String price;

  ShopResult({this.url, this.image, this.item, this.price, this.seller});

  factory ShopResult.fromJson(Map<String, dynamic> json) {
    return ShopResult(
      url: json['url'],
      seller: json['seller'],
      image: json['image'],
      item: json['item'],
      price: json['price']
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return item.toString()+" "+seller.toString()+" "+price.toString()+" "+image.toString();
  }

}