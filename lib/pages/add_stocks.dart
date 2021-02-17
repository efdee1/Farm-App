import 'package:body1/data/firestore_service.dart';
import 'package:body1/models/stocks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter/services.dart';

class AddStocksPage extends StatefulWidget {
  final Stocks stocks;

  const AddStocksPage({Key key, this.stocks}) : super(key: key);
  @override
  _AddStocksPageState createState() => _AddStocksPageState();
}

class _AddStocksPageState extends State<AddStocksPage> {
  String title;
  int price;
  int amount;
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
    _titleController = TextEditingController(text: isEditMote  ?
    widget.stocks.title: '');
   // _priceController = TextEditingController(text: isEditStocks ?
   // widget.stocks.price: '');
   // _amountController = TextEditingController(text: isEditStocks ?
  //  widget.stocks.amount:'');
    _priceNode = FocusNode();
    _amountNode = FocusNode();
  }

  get isEditMote => widget.stocks != null;

  @override
  Widget build(BuildContext  context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMote ? 'Edit stocks':'Add Stocks'),
        backgroundColor: Colors.grey[800],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                textInputAction: TextInputAction.next,
                onEditingComplete: (){
                  FocusScope.of(context).requestFocus(_priceNode);
                },
                controller: _titleController,

                validator: (val){
                  if (val==null || val.isEmpty)
                    return "Title cannot Empty";
                  return null;
                },
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: "title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0,),
              TextFormField(
                focusNode: _priceNode,
                controller: _priceController,
                textInputAction: TextInputAction.next,
                onEditingComplete: (){
                  FocusScope.of(context).requestFocus(_amountNode);
                },
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],


                validator: (val){
                  if (val==null || val.isEmpty){
                    return 'price is empty';
                  }else if(!RegExp(r"^[0-9]*$").hasMatch(val)){
                    return 'Enter a valid amount';
                  }else{
                    return null;
                  }
                },
                onChanged: (val){
                  setState(() => price = int.parse(val));
                },
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true
                ) ,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: "price",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0,),
              TextFormField(
                focusNode: _amountNode,
                controller: _amountController,

                validator: (val){
                  if (val==null || val.isEmpty){
                    return 'amount is empty';
                  }else if(!RegExp(r"^[0-9]*$").hasMatch(val)){
                    return 'Enter a valid amount';
                  }else{
                    return null;
                  }
                },

                onChanged: (val){
                  setState(() => amount = int.parse(val));
                },
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number ,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: "amount",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0,),
              RaisedButton(
                color: Colors.grey[600],
                textColor: Colors.white,
                child: Text(isEditMote ? "update":"Save"),
                onPressed: () async{
                  if (_formkey.currentState.validate()){
                     _formkey.currentState.save();

                    try{
                      if(isEditMote){
                        Stocks stocks = Stocks(title: _titleController.text,price: price,amount: amount,
                          id: widget.stocks.id,
//                      price:int(_priceController).text,
                        );
                        await FirestoreService().updateStocks(stocks);
                      }else {
                        Stocks stocks = Stocks(title: _titleController.text,price: price,amount: amount,
                         // id: widget.stocks.id,
//                      price:int(_priceController).text,
                        );
                        await FirestoreService().addStocks(stocks);
                      }
                      Navigator.pop(context);
                    }catch (e){
                      print(e);
                    }
                  }
//                  try{
//                    await FirestoreService().addStocks(
//                      Stocks(title: _titleController.text,price: price,amount: amount
////                      price:int(_priceController).text,
//                      ),
//                    );
//                    Navigator.pop(context);
//                  }catch (e){
//                    print(e);
//                  }
//                  Navigator.pop(context);
//                  FirestoreService().addStocks(
//                    Stocks(title: _titleController.text,price: price,amount: amount
////                      price:int(_priceController).text,
//                       ),
//                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

//Text('price: \$${stocks.price},\namount: ${stocks.amount}'),