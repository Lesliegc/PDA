class ProjectEntity {
  List<ProjectData> data;
  String code;

  ProjectEntity({this.data, this.code});

  ProjectEntity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ProjectData>();
      (json['data'] as List).forEach((v) {
        data.add(new ProjectData.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class ProjectData {
  int taskid;
  String sendStartTime;
  String logisticsname;
  int items;
  int printcount;
  String amount;

  ProjectData(
      {this.taskid,
      this.sendStartTime,
      this.logisticsname,
      this.items,
      this.printcount,
      this.amount});

  ProjectData.fromJson(Map<String, dynamic> json) {
    taskid = json['taskid'];
    sendStartTime = json['sendStartTime'];
    logisticsname = json['logisticsname'];
    items = json['items'];
    printcount = json['printcount'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskid'] = this.taskid;
    data['sendStartTime'] = this.sendStartTime;
    data['logisticsname'] = this.logisticsname;
    data['items'] = this.items;
    data['printcount'] = this.printcount;
    data['amount'] = this.amount;
    return data;
  }
}
