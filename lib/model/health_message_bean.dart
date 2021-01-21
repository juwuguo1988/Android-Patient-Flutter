
import 'dart:convert' show json;

class HealthNewsBean {

  List<HealthNewBean> _news;
  List<HealthNewBean> get news => _news;

  HealthNewsBean({
    List<HealthNewBean> news,}):_news=news;
  static HealthNewsBean fromJson(jsonRes){ if(jsonRes == null) return null;


  List<HealthNewBean> news = jsonRes['news'] is List ? []: null;
  if(news!=null) {
    for (var item in jsonRes['news']) { if (item != null) { news.add(HealthNewBean.fromJson(item));  }
    }
  }
  return HealthNewsBean(
    news:news,);}

  Map<String, dynamic> toJson() => {
    'news': _news,
  };
  @override
  String  toString() {
    return json.encode(this);
  }
}

class HealthNewBean {

  String _title;
  String get title => _title;
  String _digest;
  String get digest => _digest;
  String _url;
  String get url => _url;
  String _imageThumbUrl;
  String get imageThumbUrl => _imageThumbUrl;
  int _updateTime;
  int get updateTime => _updateTime;

  HealthNewBean({
    String title,
    String digest,
    String url,
    String imageThumbUrl,
    int updateTime,}):_title=title,_digest=digest,_url=url,_imageThumbUrl=imageThumbUrl,_updateTime=updateTime;
  static HealthNewBean fromJson(jsonRes)=>jsonRes == null? null:HealthNewBean(
    title : jsonRes['title'],
    digest : jsonRes['digest'],
    url : jsonRes['url'],
    imageThumbUrl : jsonRes['imageThumbUrl'],
    updateTime : jsonRes['updateTime'],);

  Map<String, dynamic> toJson() => {
    'title': _title,
    'digest': _digest,
    'url': _url,
    'imageThumbUrl': _imageThumbUrl,
    'updateTime': _updateTime,
  };
  @override
  String  toString() {
    return json.encode(this);
  }
}