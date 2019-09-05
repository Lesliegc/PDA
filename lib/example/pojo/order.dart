class Order{
  String name; // 用户
  String orderNumber; // 订单编号
  String createtime; // 创建时间
  String status; // 订单状态
  double pay; // 付款金额
  String shopid; // 门店id
  String channel; // 渠道

  // 构造函数
  Order(String name,String orderNumber,String createtime,String status,double pay,String shopid,String channel){
    this.name = name;
    this.orderNumber = orderNumber;
    this.createtime = createtime;
    this.status = status;
    this.pay = pay;
    this.shopid = shopid;
    this.channel = channel;
  }

}