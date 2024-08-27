import 'package:expense_tracker_app/components/expense_summary.dart';
import 'package:expense_tracker_app/components/expense_tile.dart';
import 'package:expense_tracker_app/data/expense_data.dart';
import 'package:expense_tracker_app/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
final newExpenseNameController=TextEditingController();
final newExpenseAmountController=TextEditingController();

void addNewExpense(){
showDialog(context: context, builder: (context)=>AlertDialog(
  title: Text('Add New Expense'),
  content: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
    //expense name 
    TextField(
      controller: newExpenseNameController,
    ),
    //expense amount
    TextField(
      controller: newExpenseAmountController,
    ),
  ],),
  actions: [
    //save button
  MaterialButton(onPressed: save,child: Text('Save'),),
    //cancel button
     MaterialButton(onPressed: cancel,child: Text('Cancel'),),
  ],
));
}
 //save 
void save(){
  ExpenseItem newExpense=ExpenseItem(
  name: newExpenseNameController.text, 
  amount: newExpenseAmountController.text, 
  dateTime: DateTime.now());
Provider.of<ExpenseData>(context,listen: false).addNewExpense(newExpense);
newExpenseNameController.clear();
newExpenseAmountController.clear();
Navigator.pop(context);
}
 //cancel
 void cancel(){
Navigator.pop(context);
 }
  @override
Widget build(BuildContext context) {
  return Consumer<ExpenseData>(
    builder: (context, value, child) {
      return Scaffold(
        backgroundColor: Colors.grey[350],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          child: const Icon(Icons.add),
        ),
        body: value == null || value.getAllExpenseList().isEmpty
            ? Center(
                child: FloatingActionButton(
                  
                  onPressed: addNewExpense,
                  child: const Text('    Add Expense',style: TextStyle(fontWeight: FontWeight.w900),),
                ),
              )
            : ListView(children: [
              //weekly summmary
              ExpenseSummary(startOfWeek: value.startOfWeekDate()),
              const SizedBox(height: 20,),
              //expense list
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: value.getAllExpenseList().length,
                itemBuilder: (context, index) => ExpenseTile(
                name: value.getAllExpenseList()[index].name,
                amount: value.getAllExpenseList()[index].amount,
                dateTime: value.getAllExpenseList()[index].dateTime)
              ),
            ],)
      );
    },
  );
}

  }