import 'package:expense_tracker_app/bar%20graph/individual_bar.dart';

class BarData {
  final double  sunAmount;
  final double  monAmount;
  final double  tueAmount;
  final double  wedAmount;
  final double  thrAmount;
  final double  friAmount;
  final double  satAmount;
  

  BarData({required this.sunAmount, required this.monAmount, required this.tueAmount, required this.wedAmount, required this.thrAmount, required this.friAmount, required this.satAmount});
  List<IndividualBar> barData=[];
  void initializeBardata(){
    barData=[
      IndividualBar(x: 0, y: sunAmount),
      IndividualBar(x: 0, y: monAmount),
      IndividualBar(x: 0, y: tueAmount),
      IndividualBar(x: 0, y: wedAmount),
      IndividualBar(x: 0, y: thrAmount),
      IndividualBar(x: 0, y: friAmount),
      IndividualBar(x: 0, y: satAmount),

    ];
  }

}