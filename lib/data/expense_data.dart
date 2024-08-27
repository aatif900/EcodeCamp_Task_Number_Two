import 'package:expense_tracker_app/datetime/date_time_helper.dart';
import 'package:expense_tracker_app/models/expense_item.dart';
import 'package:flutter/material.dart';


class ExpenseData extends ChangeNotifier {
  //list of all Expenses
  List<ExpenseItem>overallExpenseList =[];
  //get Expense list
  List<ExpenseItem> getAllExpenseList(){
    return overallExpenseList;
  }
  // add new expense
  void addNewExpense(ExpenseItem newExpense){
     overallExpenseList.add(newExpense);
     notifyListeners();
  }
  //delete expense 
   void deleteExpense(ExpenseItem expense){
     overallExpenseList.remove(expense);
     notifyListeners();
  }
  //get weekday from datetime object
  String getDayName(DateTime datetime){
    switch (datetime.weekday) {
      case 1:
      return 'Mon';
      case 2:
      return 'Tue';
      case 3:
      return 'Wed';
      case 4:
      return 'Thr';
      case 5:
      return 'Fri';
      case 6:
      return 'Sat';
      case 7:
      return 'Sun';  
      default:
      return '';
    }
  }
  //get date for start of week
  DateTime startOfWeekDate(){
     DateTime? startOfWeek;
     //getTodayDate
     DateTime today=DateTime.now();
     //go backward to find sunday
     for(int i=0;i<7;i++){
      if(getDayName(today.subtract(Duration(days:i )))=='Sun'){
        startOfWeek=today.subtract(Duration(days: i));
      }
     }
     return startOfWeek!;
  }

  /*
   convert overall list of expense into daily expwnse summary
   */
  Map<String,double> calculateDailyExpenseSummary(){
    Map<String,double> dailyExpenseSummary={};
    for (var expense in overallExpenseList){
      String date= convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);
      if(dailyExpenseSummary.containsKey(date)){
        double currentAmount=dailyExpenseSummary[date]!;
        currentAmount+=amount;
        dailyExpenseSummary[date]=currentAmount;
      }else{
        dailyExpenseSummary.addAll({date:amount}); 
      }

    }
    return dailyExpenseSummary;
  
  }
}