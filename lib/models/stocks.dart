class Stocks {
   String key;
  final String title;
  final int price;
  final int amount;
  final String id;

  Stocks({this.title, this.price, this.amount, this.id});

  Stocks.fromMap(Map<String,dynamic> data, String id):

      title = data ['title'],
        price = data ['price'],
        amount = data ['amount'],
        key = data['key'],
        id = id;

  Map<String, dynamic> toMap(){
    return{
      "title" : title,
      "price" : price,
      "amount" : amount,
    };
  }


}