import 'package:body1/data/firestore_service2.dart';
import 'package:body1/models/sales.dart';
import 'package:body1/models/sell.dart';
import 'package:body1/models/stocks.dart';
import 'package:body1/pages/home_page.dart';
import 'package:body1/pages/sales_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SellPage extends StatelessWidget {

  DateTime _currentdate = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    String _formatdate = new DateFormat('HH:mm a , MM/dd/yyyy').format(_currentdate);



    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,

        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder:(context)=> HomePage()),);
          },
        ),
        title: Text('Sales Activities',
          style: TextStyle(
            color: Colors.black,
          ),
          textAlign:TextAlign.center,
        ),
      ),
      body: StreamBuilder(
        stream:FirestoreService2().getSales(),
        builder:(BuildContext context, AsyncSnapshot<List<Sales >>snapshot){
          if (snapshot.hasError || !snapshot.hasData )
            return CircularProgressIndicator();
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
              Sales  sales = snapshot.data[index];
                return Card(
                  color: Colors.orange,
                  shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.fromLTRB(18,0,8,0),
                    title: Text(sales.title),
                    subtitle:  Text('\nprice: \$${sales.price} \n\namount: ${sales.amount} \n\nDate: $_formatdate',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    //-\n\ntotalsale: \$${stock.totalsale}
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
//                      IconButton(
//                        color: Colors.blue ,
//                        icon: Icon(Icons.edit),
//                        onPressed: ()=> Navigator.push(context,
//                            MaterialPageRoute(
//                              builder:  (_) => AddStocksPage(sell: sell),
//                            )),
//                      ),
//                      IconButton(
//                        color: Colors.red ,
//                        icon: Icon(Icons.delete),
//                        onPressed: ()=> _deleteSells(context,sell.id),
//                      ),
                      ],
                    ),
                    isThreeLine: true,
                    onTap: ()=>Navigator.push(
                      context,MaterialPageRoute(
                      builder: (_) => SalesDetailPage(sales: sales,),
                    ),
                    ),
                  ),
                );
              });
        },
      ),
//      floatingActionButton: FloatingActionButton(
//
//        backgroundColor: Colors.amber,
//        child: Icon(Icons.add),
//
//        onPressed: (){Navigator.push(context, MaterialPageRoute(
//            builder: (_)=> AddStocksPage()
//        ));
//        },
//      ),
    );
  }

  void _deleteStocks(BuildContext context,String id)async{
    if(await _showConfirmationDialog(context)) {
      try{
        await FirestoreService2().deleteStock( id);
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