class Sales {
  final String title;
  final int price;
  final int amount;
  final String id;
  final int totalsale;
  DateTime createdAt;

  Sales({this.title, this.price, this.amount, this.id, this.createdAt,this.totalsale});

  Sales.fromMap(Map<String,dynamic> data, String id):
        title = data ['title'],
        price = data ['price'],
        amount = data ['amount'],
        id = id,
        createdAt = data['createdAt'].toDate(),
         totalsale = data ['totalsale'];


  Map<String, dynamic> toMap(){
    return{
      "title" : title,
      "price" : price,
      "totalsale" : totalsale,
      "amount" : amount,
       "createdAt" : createdAt,
    };
  }


}