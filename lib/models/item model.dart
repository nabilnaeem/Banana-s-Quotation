class Item_Model{

  String item;
  double quantity;
  double price;



  Item_Model(
      {required this.item,required this.quantity,required this.price});
  Item_Model.fromjson(map):this(
      item: map['item'],
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

}