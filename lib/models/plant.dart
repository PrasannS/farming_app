

class Plant {
  int id;
  String uid;
  int progress;
  double price;
  String name;
  String image;


  Plant({this.id, this.uid, this.progress, this.price, this.name, this.image});

  Map<String, dynamic> toMap() =>{
    "id": id,
    "uid": uid,
    "progress": progress,
    "price":price,
    'image':image,
    
    "name":name,
  };

  factory Plant.fromMap(Map<String, dynamic> json) => new Plant(
      id: json["id"],
      price:json["price"],
      uid:json["uid"],
      progress:json["progress"],
      name: json["name"],
      image: json["image"]
  );

  @override
  String toString() {
    return 'Plant{id: $id, uid: $uid, progress: $progress, price $price, name $name}';
  }

}