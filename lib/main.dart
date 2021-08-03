import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/new_Transacction.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'models/transaction.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';
void main()=> runApp(MyApp());
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'Personal Expenses',
      theme:ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.amberAccent,
        textTheme: ThemeData.light().textTheme.copyWith(
          button: TextStyle(color: Colors.white),

        )
      ),
      home: MyHomePage(),

    );
  }
}
class MyHomePage extends StatefulWidget{
  @override
_MyHomePageState createState()=> _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _usertransactions = [

  ];
 List<Transaction> get _recentTransactions{
   return _usertransactions.where((tx){
     return tx.date.isAfter(DateTime.now().subtract(Duration(days:7)));
   }).toList();
 }
  void _addNewTransaction(String Txtitle, double Txamount,DateTime TxDate ) {
    final newTx = Transaction(title: Txtitle,
        amount: Txamount,
        date: TxDate,
        id: DateTime.now().toString());

    setState(() {
      _usertransactions.add(newTx);
    });
  }
    void _startAddNewTransaction(BuildContext ctx) {
      showModalBottomSheet(context: ctx, builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },);}
      void _deleteTransaction(String id){
        setState(() {
          _usertransactions.removeWhere((tx){
            return tx.id==id;
          });
        });
      }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Personal Expenses'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),)
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Chart(_recentTransactions),
                  TransactionList(_usertransactions,_deleteTransaction),
                ]
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      );
    }
  }

