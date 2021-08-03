import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/main.dart';
class TransactionList extends StatelessWidget{

  final List<Transaction> transaction;
  final Function deleteTx;
  TransactionList(this.transaction,this.deleteTx);

  @override
  Widget build (BuildContext context){
return Container(
  height: 600,
  child: transaction.isEmpty ? Column(
    children: <Widget>[
      Text('No Transactions are added yet',
      style: Theme.of(context).textTheme.subtitle1,)
    ],
  )
  :ListView.builder(itemBuilder: (ctx,index){
    return Card(
      elevation: 5,
    margin: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
    child:  ListTile(
      leading: CircleAvatar(radius: 30,child:Padding(
        padding: EdgeInsets.all(5),
        child:FittedBox(
      child: Text('Rs${transaction[index].amount}'),),
    ),
    ),
      title: Text(transaction[index].title,
      style: Theme.of(context).textTheme.title,
      ),
      subtitle:Text(DateFormat.yMMMd().format(transaction[index].date)) ,
     trailing: IconButton(icon:Icon(Icons.delete),color:Theme.of(context).errorColor,
     onPressed: (){
       deleteTx(transaction[index].id);
     },),
    )
    );
    },
    itemCount:transaction.length,)
);}

  }
