class GoodListBean {
  int total_results;
  List<GoodList> order =[];

  GoodListBean(
      {this.total_results,
        this.order});

  factory GoodListBean.from(Map<String, dynamic> parsedJson) {
//    List<Article> articles = new List();
//    articles = list.map((i) => Article.fromJson(i)).toList();
    return GoodListBean(
      total_results: parsedJson["total_results"],
      order: (parsedJson['order'] as List)
          .map((i) => GoodList.fromJson(i))
          .toList(),
    );
  }
}

class GoodList {
  final String bill_type;
  final String channel_keyword;
  final String channel_sheetno;
  final String oid;
  final String order_time;
  final String order_type;
  final String pay_over;
  final String status;
  final List<Detail> detail;

  GoodList(
      {
        this.bill_type,
        this.channel_keyword,
        this.channel_sheetno,
        this.oid,
        this.order_time,
        this.order_type,
        this.pay_over,
        this.status,
        this.detail});

  factory GoodList.fromJson(Map<String, dynamic> parsedJson) {
    var detailFormJson = parsedJson['detail'] as List;
    print(detailFormJson.runtimeType);
    List<Detail> detailList = detailFormJson.map((i) =>Detail.fromJson(i)).toList();
    return GoodList(
      bill_type: parsedJson['bill_type'],
      channel_keyword: parsedJson['channel_keyword'],
      channel_sheetno: parsedJson['channel_sheetno'],
      oid: parsedJson['oid'],
      order_time: parsedJson['order_time'],
      order_type: parsedJson['order_type'],
      pay_over: parsedJson['pay_over'],
      status: parsedJson['status'],
      detail: detailList
    );
  }

}

class Detail{
   String barcode;
   String item_code;
   String item_name;
   String odid;
   int order_no;
   int original_price;
   int sale_value;
   int sale_qty;
   bool status;
   int unsort_qty;

  Detail({this.item_name, this.sale_value,this.sale_qty});

  factory Detail.fromJson(Map<String, dynamic> parsedJson){
    return Detail(
        item_name: parsedJson['item_name'],
        sale_value: parsedJson['sale_value'],
        sale_qty :parsedJson['sale_qty']
    );
  }
}
