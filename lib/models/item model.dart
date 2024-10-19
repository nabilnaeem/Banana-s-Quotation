class Item_Model{

  String item;
  String id;
  double quantity;
  double price;



  Item_Model(
      {required this.item,required this.quantity,required this.price,required this.id});
  Item_Model.fromjson(map):this(
      item: map['item'],
      id: map['id'].toString(),
      quantity: double.parse(map['quantity']),
      price: double.parse(map['price']),
  );
  tojson(id) => {
    'quote_id':id.toString(),
    'item':item,
    'quantity':quantity.toString(),
    'price':price.toString(),

  };
  double getTotalCost() {
    return price * quantity;
  }
  Item_Model copy() {
    return Item_Model(item: this.item, quantity: this.quantity, price: this.price,id:this.id);
  }
}