import 'package:body1/data/firestore_service.dart';
import 'package:body1/data/firestore_service2.dart';
import 'package:body1/models/sell.dart';
import 'package:body1/models/sell.dart';
import 'package:body1/models/stocks.dart';
import 'package:body1/models/stocks.dart';
import 'package:body1/models/stocks.dart';
import 'package:body1/models/stocks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'add_stock_page.dart';



class AddStocksDetailPage extends StatefulWidget {



  final Stocks stock;
  const AddStocksDetailPage({Key key, @required this.stock}) : super(key: key);
  @override
  _AddStocksDetailPageState createState() => _AddStocksDetailPageState();
}

class _AddStocksDetailPageState extends State<AddStocksDetailPage> {

  String title;
  int totalsale;
  int price;
  int amount;
  DateTime  created;
  final _formkey = GlobalKey<FormState>();

  GlobalKey<FormState>_key= GlobalKey<FormState>();
  TextEditingController _titleController  ;
  TextEditingController _priceController;
  TextEditingController _amountController ;
  FocusNode _priceNode;
  FocusNode _amountNode;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController(text: isEditSales  ?
    widget.stock.title: '');
    // _priceController = TextEditingController(text: isEditStocks ?
    // widget.stocks.price: '');
//     _amountController = TextEditingController(text: isEditStocks ?
//      widget.stocks.amount:'');
    _priceNode = FocusNode();
    _amountNode = FocusNode();
  }

  get isEditSales => widget.stock != null;

  int quantity = 0;
  void add(){
    setState(() {
      quantity++;
    });
  }
  void minus(){
    setState(() {
      if (quantity !=0)
        quantity--;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adding Stocks'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.stock.title,
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.title.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),
              ),
              const SizedBox(height: 10.0,),
              Text('name of stock: ${widget.stock.title}\n\nprice of stock: \$${widget.stock.price}  ',
                style: TextStyle(
                    fontSize: 16.0
                ),
              ),
              const SizedBox(height: 30.0,),
              Container(
                alignment: Alignment.center,
                child: FlatButton(
                  padding: EdgeInsets.symmetric(horizontal:170,vertical:7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  onPressed: (){
                    setState(() {
                      quantity += 1;
                    });
                  },
                  child: Text("+",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 15.0,),
              Container(
                alignment: Alignment.center,
                child: Text('$quantity',
                  //textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.amber,
                    //letterSpacing: 2.0,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15.0,),
              Container(
                alignment: Alignment.center,
                child: FlatButton(
                  padding: EdgeInsets.symmetric(horizontal:170,vertical:7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  onPressed: (){
                    setState(() {
                      quantity -= 1;
                      if(quantity < 1)
                        quantity=0;
                    });
                  },
                  child: Text("-",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 2.0,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 50.0,),
              StreamBuilder(
                stream: FirestoreService().getStocks(),
                builder: (BuildContext context, AsyncSnapshot<List<Stocks>>snapshot){
                  return Container(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index){
                          Stocks stocks = snapshot.data[index];
                          return Container(
//                            height: 45,
//                            alignment: Alignment.center,
//                            child: FlatButton(
//                              padding: EdgeInsets.symmetric(horizontal:0,vertical:7),
//                              onPressed: (){
//                                setState(() {
//                                  // ignore: unnecessary_statements
//                                  quantity*stock.price-stock.amount;
//                                });
//                              },
//                              child: Text( "Pay",
//                                textAlign: TextAlign.center,
//                                style: TextStyle(
//                                  color: Colors.black,
//                                  letterSpacing: 2.0,
//                                  fontSize: 28.0,
//                                ),
//                              ),
//                              color: Colors.lightBlueAccent,
//                            ),

                          );
                        }
                    ),
                  );
                },
              ),



              Container(

                alignment: Alignment.center,
                child: FlatButton(
                  padding: EdgeInsets.symmetric(horizontal:0,vertical:7),
                  onPressed: ()   {
                    setState(() {
                      // ignore: unnecessary_statements
                      amount =widget.stock.amount+quantity;
                    });
                    FirestoreService(id:widget.stock.id).updateAmount(amount);
                    Navigator.push(
                        context,MaterialPageRoute(builder: (context)
                    {return AddStocksPages();
                    })
                    );
                  },
                  child: Text("Add",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 2.0,
                      fontSize: 28.0,
                    ),
                  ),
                  color: Colors.lightBlueAccent,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }}