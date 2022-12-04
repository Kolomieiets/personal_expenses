import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/transaction_list.dart';

void main() {
  // SystemChrome.setPreferredOrientations(DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.amberAccent,
          errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
    String txTitle,
    double txAmount,
    DateTime chosenDate,
  ) {
    final Transaction newTX = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    _userTransactions.add(newTX);

    setState(() {});
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTRansaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
        title: const Text(
          'Personal Expenses',
          style: TextStyle(fontFamily: 'Pen Sans'),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add),
          )
        ]);
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height - MediaQuery.of(context).padding.top) *
                    0.25,
                child: Chart(_recentTransactions)),
            Container(
              height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height - MediaQuery.of(context).padding.top) *
                    0.75,
              child: TransactionList(_userTransactions, _deleteTRansaction)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
