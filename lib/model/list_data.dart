//import 'dart:convert';

// ListData listDataFromJson(String str, String arguPageType) =>
//     ListData.fromJson(json: json.decode(str), arguPageType: arguPageType);

class ListData {
  String message;
  int result, count, pageSize, lastId, lastS;
  Map<String, dynamic>? rows;

  ListData({
    this.result = 0,
    this.message = '',
    this.count = 0,
    this.pageSize = 10,
    this.lastId = 0,
    this.lastS = 0,
    this.rows,
  });

  factory ListData.fromJson({
    required Map<String, dynamic> json,
    required String arguPageType,
  }) {
    final Map<String, dynamic> replaceRowsData = <String, dynamic>{};
    if (json['rows'].isNotEmpty) {
      int idx = 0;
      for (final entry in json['rows'].entries) {
        replaceRowsData[idx.toString()] = entry.value;
        idx++;
      }
    }
    return ListData(
      result: json['result'] ?? 0,
      message: json['message'] ?? '',
      count: json['count'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      lastId: json['lastID'] == null ? 0 : int.parse(json['lastID']),
      lastS: json['lastS'] == null ? 0 : int.parse(json['lastS']),
      rows: Map.from(replaceRowsData).map(
        (k, v) {
          if (arguPageType == 'h') {
            return MapEntry<String, HospitalData>(
              k,
              HospitalData.fromJson(v),
            );
          } else if (arguPageType == 'e') {
            return MapEntry<String, ExpertsData>(
              k,
              ExpertsData.fromJson(v),
            );
          } else if (arguPageType == 'i') {
            return MapEntry<String, InfoData>(
              k,
              InfoData.fromJson(v),
            );
          } else {
            return MapEntry<String, CaseData>(
              k,
              CaseData.fromJson(v),
            );
          }
        },
      ),
    );
  }
}

class CaseData {
  int uid;
  String? title;
  String? txt;
  List<String>? imgs;

  CaseData({
    required this.uid,
    this.title,
    this.txt,
    this.imgs,
  });

  factory CaseData.fromJson(Map<String, dynamic> json) => CaseData(
        uid: json['uid'],
        title: json['title'] ?? '',
        txt: json['txt'] ?? '',
        imgs: json['imgs'] == null
            ? []
            : List<String>.from(
                json['imgs'].map(
                  (x) => x ?? '',
                ),
              ),
      );
}

class HospitalData {
  int uid;
  String? cnTitle;
  String? krTitle;
  String? hospitalImage;
  String? items;
  Map<String, SubExperts>? subExpertsList;
  Map<String, SubCase>? subCaseList;

  HospitalData({
    required this.uid,
    this.cnTitle,
    this.krTitle,
    this.hospitalImage,
    this.items,
    this.subExpertsList,
    this.subCaseList,
  });

  factory HospitalData.fromJson(Map<String, dynamic> json) => HospitalData(
        uid: json['uid'],
        cnTitle: json['cn'] ?? '',
        krTitle: json['kr'] ?? '',
        hospitalImage: json['img'] ?? '',
        items: json['items'] ?? '',
        subExpertsList: json['ex'] == null
            ? {}
            : Map.from(json["ex"]).map(
                (k, v) =>
                    MapEntry<String, SubExperts>(k, SubExperts.fromJson(v)),
              ),
        subCaseList: json['case'] == null
            ? {}
            : Map.from(json["case"]).map(
                (k, v) => MapEntry<String, SubCase>(k, SubCase.fromJson(v)),
              ),
        // subCaseList: json['case'] == null
        //     ? {}
        //     : Map.from(json['case']).map(
        //         (k, v) {
        //           var mapEntry = MapEntry<String, dynamic>(k, v);
        //           return mapEntry;
        //         },
        //       ),
      );
}

class ExpertsData {
  int uid;
  String? sCur;
  String? name;
  String? cn;
  String? pos;
  String? items;
  String? img;
  Map<String, SubCase>? subCaseList;
  Map<String, SubInfo>? subInfoList;
  //SubInfo? subInfo;

  ExpertsData({
    required this.uid,
    this.sCur,
    this.name,
    this.cn,
    this.pos,
    this.items,
    this.img,
    this.subCaseList,
    this.subInfoList,
    //this.subInfo,
  });

  factory ExpertsData.fromJson(Map<String, dynamic> json) => ExpertsData(
        uid: json["uid"],
        sCur: json["s_cur"] ?? '',
        name: json["name"] ?? '',
        cn: json["cn"] ?? '',
        pos: json["pos"] ?? '',
        items: json["items"] ?? '',
        img: json["img"] ?? '',
        subCaseList: json['case'] == null
            ? {}
            : Map.from(json["case"]).map(
                (k, v) => MapEntry<String, SubCase>(k, SubCase.fromJson(v)),
              ),
        subInfoList: json['info'] == null
            ? {}
            : Map.from(json["info"]).map(
                (k, v) => MapEntry<String, SubInfo>(k, SubInfo.fromJson(v)),
              ),
        //subInfo: json["info"] == null ? null : SubInfo.fromJson(json["info"]),
      );
}

class InfoData {
  int uid;
  String? title;
  String? items;
  String? summary;
  String? img;

  InfoData({
    required this.uid,
    this.title,
    this.items,
    this.summary,
    this.img,
  });

  factory InfoData.fromJson(Map<String, dynamic> json) => InfoData(
        uid: json["uid"],
        title: json["title"] ?? '',
        items: json["items"] ?? '',
        summary: json["summ"] ?? '',
        img: json["img"] ?? '',
      );
}

class SubExperts {
  String? name;
  String? img;

  SubExperts({
    this.name,
    this.img,
  });

  factory SubExperts.fromJson(Map<String, dynamic> json) => SubExperts(
        name: json["name"] ?? '',
        img: json["img"] ?? '',
      );
}

class SubCase {
  String? title;
  String? txt;
  List<String>? imgs;

  SubCase({
    this.title,
    this.txt,
    this.imgs,
  });

  factory SubCase.fromJson(Map<String, dynamic> json) => SubCase(
        title: json["title"] ?? '',
        txt: json["txt"] ?? '',
        imgs: json['imgs'] == null
            ? []
            : List<String>.from(
                json['imgs'].map(
                  (x) => x ?? '',
                ),
              ),
      );
}

class SubInfo {
  String? title;
  String? items;
  String? summary;
  String? img;

  SubInfo({
    this.title,
    this.items,
    this.summary,
    this.img,
  });

  factory SubInfo.fromJson(Map<String, dynamic> json) => SubInfo(
        title: json["title"] ?? '',
        items: json["items"] ?? '',
        summary: json["summ"] ?? '',
        img: json["img"] ?? '',
      );
}
