class HealthNewsBean {
  List<HealthNewBean> news;

  HealthNewsBean({this.news});

  HealthNewsBean.fromJson(Map<String, dynamic> json) {
    if (json['news'] != null) {
      news = new List<HealthNewBean>();
      json['news'].forEach((v) {
        news.add(new HealthNewBean.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.news != null) {
      data['news'] = this.news.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HealthNewBean {
  String title;
  String digest;
  String url;
  String imageThumbUrl;
  int updateTime;

  HealthNewBean(
      {this.title, this.digest, this.url, this.imageThumbUrl, this.updateTime});

  HealthNewBean.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    digest = json['digest'];
    url = json['url'];
    imageThumbUrl = json['imageThumbUrl'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['digest'] = this.digest;
    data['url'] = this.url;
    data['imageThumbUrl'] = this.imageThumbUrl;
    data['updateTime'] = this.updateTime;
    return data;
  }
}