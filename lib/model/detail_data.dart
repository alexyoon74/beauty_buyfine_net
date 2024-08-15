class DetailData {
  int result;
  String message;
  //dynamic detailInfos;
  CaseDetailInfos? detailInfos;

  DetailData({
    this.result = 0,
    this.message = '',
    this.detailInfos,
    //required this.detailInfos,
  });

  factory DetailData.fromJson({
    required Map<String, dynamic> json,
    required String arguPageType,
  }) {
    dynamic infos;
    if (arguPageType == 'h') {
      infos = json["detail_infos"] == null
          ? null
          : HospitalDetailInfos.fromJson(json["detail_infos"]);
    } else if (arguPageType == 'e') {
      infos = json["detail_infos"] == null
          ? null
          : ExpertsDetailInfos.fromJson(json["detail_infos"]);
    } else if (arguPageType == 'i') {
      infos = json["detail_infos"] == null
          ? null
          : InfoDetailInfos.fromJson(json["detail_infos"]);
    } else if (arguPageType == 'c') {
      // infos = json["detail_infos"] == null
      //     ? null
      //     : CaseDetailInfos.fromJson(json["detail_infos"]);
      CaseDetailInfos caseDetailInfos =
          CaseDetailInfos.fromJson(json["detail_infos"]);
      return DetailData(
        result: json["result"] ?? 0,
        message: json["message"] ?? '',
        detailInfos: caseDetailInfos,
      );
    }
    return DetailData(
      result: json["result"] ?? 0,
      message: json["message"] ?? '',
      detailInfos: infos,
    );
  }
}

class CaseDetailInfos {
  int uid;
  String? cTitle;
  String? writeDatetimeStr;
  String? priceInfo;
  String? otTimeInfo;
  String? recoveryPeriodInfo;
  String? relatedItems;
  String? getImgList;
  List<String>? imgs;
  String? imgCacheNum;
  String? contents;
  String? getContentsImgs;
  int? bUid;
  String? bNameCn;
  List<RelatedExperts>? relatedExperts;

  CaseDetailInfos({
    required this.uid,
    this.cTitle,
    this.writeDatetimeStr,
    this.priceInfo,
    this.otTimeInfo,
    this.recoveryPeriodInfo,
    this.relatedItems,
    this.getImgList,
    this.imgs,
    this.imgCacheNum,
    this.contents,
    this.getContentsImgs,
    this.bUid,
    this.bNameCn,
    this.relatedExperts,
  });

  factory CaseDetailInfos.fromJson(Map<String, dynamic> json) =>
      CaseDetailInfos(
        uid: int.parse(json["uid"]),
        cTitle: json["c_title"] ?? '',
        writeDatetimeStr: json["write_datetime_str"] ?? '',
        //priceInfo: json["price_info"] ?? '',
        otTimeInfo: json["ot_time_info"] ?? '',
        recoveryPeriodInfo: json["recovery_period_info"] ?? '',
        relatedItems: json["related_items"] ?? '',
        getImgList: json["get_img_list"] ?? '',
        imgs: json['imgs'] == null
            ? []
            : List<String>.from(
                json['imgs'].map(
                  (x) => x ?? '',
                ),
              ),
        imgCacheNum: json["img_cache_num"] ?? '',
        contents: json["contents"] ?? '',
        getContentsImgs: json["get_contents_imgs"] ?? '',
        bUid: json["b_uid"] == null ? 0 : int.parse(json["b_uid"]),
        bNameCn: json["b_name_cn"] ?? '',
        relatedExperts: json['related_experts'] == null
            ? []
            : List<RelatedExperts>.from(
                json['related_experts'].map(
                  (x) => RelatedExperts.fromJson(x ?? {}),
                ),
              ),
      );
}

class HospitalDetailInfos {
  int uid;
  String? bNameCn;
  String? bNameKr;
  String? homepage;
  String? medicalItems;
  String? addr;
  String? imgCacheNum;
  String? getHImgList;
  String? workTimeList;
  String? fullInfo;
  String? getFullInfoImgs;
  RelatedListTabs? relatedListTabs;

  HospitalDetailInfos({
    required this.uid,
    this.bNameCn,
    this.bNameKr,
    this.homepage,
    this.medicalItems,
    this.addr,
    this.imgCacheNum,
    this.getHImgList,
    this.workTimeList,
    this.fullInfo,
    this.getFullInfoImgs,
    this.relatedListTabs,
  });

  factory HospitalDetailInfos.fromJson(Map<String, dynamic> json) =>
      HospitalDetailInfos(
        uid: int.parse(json["uid"]),
        bNameCn: json["b_name_cn"] ?? '',
        bNameKr: json["b_name_kr"] ?? '',
        homepage: json["homepage"] ?? '',
        medicalItems: json["medical_items"] ?? '',
        addr: json["addr"] ?? '',
        imgCacheNum: json["img_cache_num"] ?? '',
        getHImgList: json["get_h_img_list"] ?? '',
        workTimeList: json["work_time_list"] ?? '',
        fullInfo: json["full_info"] ?? '',
        getFullInfoImgs: json["get_full_info_imgs"] ?? '',
        relatedListTabs: RelatedListTabs.fromJson(json["tabs"] ?? {}),
      );
}

class ExpertsDetailInfos {
  int uid;
  String? name;
  String? position;
  String? majorSpecialty;
  String? getImgUri;
  String? imgCacheNum;
  String? history;
  String? getHistoryImgs;
  int? bUid;
  String? bNameCn;
  RelatedListTabs? relatedListTabs;

  ExpertsDetailInfos({
    required this.uid,
    this.name,
    this.position,
    this.majorSpecialty,
    this.getImgUri,
    this.imgCacheNum,
    this.history,
    this.getHistoryImgs,
    this.bUid,
    this.bNameCn,
    this.relatedListTabs,
  });

  factory ExpertsDetailInfos.fromJson(Map<String, dynamic> json) =>
      ExpertsDetailInfos(
        uid: int.parse(json["uid"]),
        name: json["name"] ?? '',
        position: json["position"] ?? '',
        majorSpecialty: json["major_specialty"] ?? '',
        getImgUri: json["get_img_uri"] ?? '',
        imgCacheNum: json["img_cache_num"] ?? '',
        history: json["history"] ?? '',
        getHistoryImgs: json["get_history_imgs"] ?? '',
        bUid: json["b_uid"] == null ? 0 : int.parse(json["b_uid"]),
        bNameCn: json["b_name_cn"] ?? '',
        relatedListTabs: RelatedListTabs.fromJson(json["tabs"] ?? {}),
      );
}

class InfoDetailInfos {
  int uid;
  String? fTitle;
  String? fWriter;
  String? writeDatetimeStr;
  String? priceInfo;
  String? relatedItems;
  String? getFImgs;
  String? imgCacheNum;
  String? contents;
  String? getContentsImgs;
  int? bUid;
  String? bNameCn;
  List<RelatedExperts>? relatedExperts;

  InfoDetailInfos({
    required this.uid,
    this.fTitle,
    this.fWriter,
    this.writeDatetimeStr,
    this.priceInfo,
    this.relatedItems,
    this.getFImgs,
    this.imgCacheNum,
    this.contents,
    this.getContentsImgs,
    this.bUid,
    this.bNameCn,
    this.relatedExperts,
  });

  factory InfoDetailInfos.fromJson(Map<String, dynamic> json) =>
      InfoDetailInfos(
        uid: int.parse(json["uid"]),
        fTitle: json["f_title"] ?? '',
        fWriter: json["f_writer"] ?? '',
        writeDatetimeStr: json["write_datetime_str"] ?? '',
        priceInfo: json["price_info"] ?? '',
        relatedItems: json["related_items"] ?? '',
        getFImgs: json["get_f_imgs"] ?? '',
        imgCacheNum: json["img_cache_num"] ?? '',
        contents: json["contents"] ?? '',
        getContentsImgs: json["get_contents_imgs"] ?? '',
        bUid: json["b_uid"] == null ? 0 : int.parse(json["b_uid"]),
        bNameCn: json["b_name_cn"] ?? '',
        relatedExperts: json['related_experts'] == null
            ? []
            : List<RelatedExperts>.from(
                json['related_experts'].map(
                  (x) => RelatedExperts.fromJson(x ?? {}),
                ),
              ),
      );
}

class RelatedListTabs {
  int experts;
  int cases;
  int info;

  RelatedListTabs({
    required this.experts,
    required this.cases,
    required this.info,
  });

  factory RelatedListTabs.fromJson(Map<String, dynamic> json) =>
      RelatedListTabs(
        experts: json["experts"] ?? 0,
        cases: json["case"] ?? 0,
        info: json["info"] ?? 0,
      );
}

class RelatedExperts {
  int uid;
  String? name;

  RelatedExperts({
    required this.uid,
    this.name,
  });

  factory RelatedExperts.fromJson(Map<String, dynamic> json) => RelatedExperts(
        uid: int.parse(json["uid"]),
        name: json["name"] ?? '',
      );
}
