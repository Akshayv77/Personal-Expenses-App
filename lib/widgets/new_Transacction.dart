import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';

class NewTransaction extends StatefulWidget {

  Function tx;

  NewTransaction(this.tx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}
  class _NewTransactionState extends State<NewTransaction>{
    final _titleController = TextEditingController();
    final _amountController = TextEditingController();
    DateTime _selecteDate;
  void _submitData(){
    if(_amountController.text.isEmpty)
      return;
    final enterTtile=_titleController.text;
    final enterAmount=double.parse(_amountController.text);
    if(enterTtile.isEmpty || enterAmount<=0|| _selecteDate==null){
      return;
    }
    widget.tx(
        _titleController.text,
        double.parse(_amountController.text),
    _selecteDate,);
    Navigator.of(context).pop();}
    void _presentDatePicker(){
      showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2021), lastDate: DateTime.now()).
      then((pickedDate){
        if(pickedDate==null){
          return;
        }
        setState(() {
          _selecteDate=pickedDate;
        });

      });
    }



  @override
  Widget build(BuildContext context){
return Card(
  elevation:40,
  child: Container(
  padding: EdgeInsets.all(5),
  child:Column( crossAxisAlignment:CrossAxisAlignment.end,
  children: <Widget>[
  TextField(decoration: InputDecoration(labelText: 'Title'),
  controller: _titleController,
  onSubmitted:(_)=> _submitData ,),
  TextField(decoration: InputDecoration(labelText: 'Amount'),
  controller: _amountController,
  keyboardType: TextInputType.number,
    onSubmitted:(_)=> _submitData ,),
  Row(
    children: <Widget>[
      Expanded(
      child:Text(_selecteDate==null?'No Date Chosen': 'Picked Date:${DateFormat.yMd().format(_selecteDate)}'),
    ),
          FlatButton(
        textColor: Theme.of(context).primaryColor,
        child: Text('Choose Date',style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: _presentDatePicker,

      ),
    ],
  ),
  RaisedButton(child: Text('Add Transaction'),
  textColor: Theme.of(context).textTheme.button.color,
  onPressed: (){
  _submitData();
  },
  color: Theme.of(context).primaryColor,)
  ,]
  )
  ),
);
  }
}