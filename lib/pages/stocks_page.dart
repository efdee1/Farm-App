import 'package:body1/data/firestore_service.dart';
import 'package:body1/models/stocks.dart';
import 'package:body1/pages/add_stocks.dart';
import 'package:body1/pages/home_page.dart';
import 'package:body1/pages/stocks_details.dart';
import 'package:flutter/material.dart';

class StockPage extends StatelessWidget {
  List<Stocks>_stockslist;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,

        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder:(context)=> HomePage()),);
          },
        ),
        title: Text('STOCKS',
          style: TextStyle(
            color: Colors.black,
          ),
          textAlign:TextAlign.center,
        ),
      ),
      body: StreamBuilder(
        stream:FirestoreService().getStocks(),
            builder:(BuildContext context, AsyncSnapshot<List<Stocks >>snapshot){
          if (snapshot.hasError || !snapshot.hasData )
            return CircularProgressIndicator();
          return ListView.builder(

            itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
              Stocks stocks = snapshot.data[index];
              return ListTile(

                title: Text(stocks.title),
                subtitle:  Text('price: \$${stocks.price} \namount: ${stocks.amount}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      color: Colors.blue ,
                      icon: Icon(Icons.edit),
                      onPressed: ()=> Navigator.push(context,
                          MaterialPageRoute(
                            builder:  (_) => AddStocksPage(stocks: stocks),
                          )),
                    ),
                    IconButton(
                      color: Colors.red ,
                      icon: Icon(Icons.delete),
                      onPressed: ()=> _deleteStocks(context,stocks.id),
                    ),
                  ],
                ),
                isThreeLine: true,
               onTap: ()=>Navigator.push(
                 context,MaterialPageRoute(
                 builder: (_) => StocksDetailPage(stocks: stocks,),
               ),
               ),
              );
          });
            },
      ),
      floatingActionButton: FloatingActionButton(

        backgroundColor: Colors.amber,
        child: Icon(Icons.add),

        onPressed: (){Navigator.push(context, MaterialPageRoute(
          builder: (_) => AddStocksPage()
        ));
        },
      ),
    );
  }
  void _deleteStocks(BuildContext context,String id)async{
    if(await _showConfirmationDialog(context)) {
      try{
        await FirestoreService().deleteStocks( id);
      }catch(e){
        print(e);
      }
    }
  }
  Future<bool> _showConfirmationDialog(BuildContext context)async{
    return showDialog(
        context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        content: Text("Are you sure you want to delete?"),
        actions: <Widget>[
          FlatButton(
            color: Colors.white ,
            child: Text("Delete",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onPressed:()=>Navigator.pop(context,true),
          ),
          FlatButton(
            color: Colors.white,
            child: Text("No ",
              style: TextStyle(
                color: Colors.black
              ),
            ),
            onPressed:()=>Navigator.pop(context,false ),
          ),
        ],
      )
    );
  }
}


//subtitle:  Text('price:#\${widget.stocks.price},\n amount:{widget.stocks.amount}'),
//subtitle:  Text(stocks.price.toString()\n stocks.amount.toString()),