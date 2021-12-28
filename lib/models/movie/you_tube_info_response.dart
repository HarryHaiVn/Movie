/// id : 496243
/// results : [{"iso_639_1":"en","iso_3166_1":"US","name":"Parasite [Trailer 2] – Now Playing in New York & Los Angeles.","key":"PhPROyE0OaM","site":"YouTube","size":1080,"type":"Trailer","official":true,"published_at":"2019-10-02T16:10:02.000Z","id":"5dfdc9799824c80017df2566"},{"iso_639_1":"en","iso_3166_1":"US","name":"Parasite [Official Trailer] – In Theaters October 11, 2019","key":"isOGD_7hNIY","site":"YouTube","size":1080,"type":"Trailer","official":true,"published_at":"2019-08-14T15:04:13.000Z","id":"5d5446ef55c92600162572e3"}]

class YouTubeInfoResponse {
  YouTubeInfoResponse({
      int? id, 
      List<Results>? results,}){
    _id = id;
    _results = results;
}

  YouTubeInfoResponse.fromJson(dynamic json) {
    _id = json['id'];
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(Results.fromJson(v));
      });
    }
  }
  int? _id;
  List<Results>? _results;

  int? get id => _id;
  List<Results>? get results => _results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// iso_639_1 : "en"
/// iso_3166_1 : "US"
/// name : "Parasite [Trailer 2] – Now Playing in New York & Los Angeles."
/// key : "PhPROyE0OaM"
/// site : "YouTube"
/// size : 1080
/// type : "Trailer"
/// official : true
/// published_at : "2019-10-02T16:10:02.000Z"
/// id : "5dfdc9799824c80017df2566"

class Results {
  Results({
      String? iso6391, 
      String? iso31661, 
      String? name, 
      String? key, 
      String? site, 
      int? size, 
      String? type, 
      bool? official, 
      String? publishedAt, 
      String? id,}){
    _iso6391 = iso6391;
    _iso31661 = iso31661;
    _name = name;
    _key = key;
    _site = site;
    _size = size;
    _type = type;
    _official = official;
    _publishedAt = publishedAt;
    _id = id;
}

  Results.fromJson(dynamic json) {
    _iso6391 = json['iso_639_1'];
    _iso31661 = json['iso_3166_1'];
    _name = json['name'];
    _key = json['key'];
    _site = json['site'];
    _size = json['size'];
    _type = json['type'];
    _official = json['official'];
    _publishedAt = json['published_at'];
    _id = json['id'];
  }
  String? _iso6391;
  String? _iso31661;
  String? _name;
  String? _key;
  String? _site;
  int? _size;
  String? _type;
  bool? _official;
  String? _publishedAt;
  String? _id;

  String? get iso6391 => _iso6391;
  String? get iso31661 => _iso31661;
  String? get name => _name;
  String? get key => _key;
  String? get site => _site;
  int? get size => _size;
  String? get type => _type;
  bool? get official => _official;
  String? get publishedAt => _publishedAt;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['iso_639_1'] = _iso6391;
    map['iso_3166_1'] = _iso31661;
    map['name'] = _name;
    map['key'] = _key;
    map['site'] = _site;
    map['size'] = _size;
    map['type'] = _type;
    map['official'] = _official;
    map['published_at'] = _publishedAt;
    map['id'] = _id;
    return map;
  }

}