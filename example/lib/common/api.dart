
class Api {

  static const String BASE_URL = "http://172.17.10.235:8080/order-center/ui/PDA/";

  //获取用户需要拣货的任务
  static const String Task = "getMyJianHuoTask.action";

  //开始拣货任务
  static const String ARTICLE_LIST = "startJianHuo.action";

  //PDA拣货完成
  static const String TREE = "overJianHuo.action";

  //开始验货
  static const String NAVI = "getDabaoTaskInfo.action";

  //盲扫提交
  static const String PROJECT = "checkPackTask.action";

  //订单任务打包完成
  static const String PROJECT_LIST = "overDaBao.action";


}