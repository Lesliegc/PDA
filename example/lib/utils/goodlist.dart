
class Shop{
  final int taskid;
  final String sendStartTime;
  final String logisticsname;
  final int items;
  final int printcount;
  final String amount;
  bool selected=false;//默认为未选中
  Shop({this.taskid, this.sendStartTime, this.logisticsname, this.items, this.printcount, this.amount});
}
 
  final List<Shop> shops=<Shop>[
    Shop(
      taskid: 99161026400122, 
      sendStartTime:"2016-10-28 12:00:00",
      logisticsname:"A",
      items: 2,
      printcount: 0,
      amount: '0',),
  ];
