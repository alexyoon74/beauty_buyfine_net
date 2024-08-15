// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:beauty_buyfine_net/components/crypto_func.dart';
import 'package:beauty_buyfine_net/constants/constants.dart';
import 'package:beauty_buyfine_net/model/detail_data.dart';
import 'package:beauty_buyfine_net/model/list_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseUrl = 'https://beauty.buyfine.net/api';
  static String plainText = '^$nowTimeNum';
  static String encryptedText = encryptText(plainText, keyCode);

  static Future<DetailData> getDetailData({
    required String pageType,
    required int uid,
  }) async {
    DetailData detailDataInstance;
    try {
      final body = {
        'type': pageType,
        'uid': uid.toString(),
        'app_key': appKey,
        'sign_key': encryptedText,
        'sign_type': 'app',
      };
      final response = await http.post(
        Uri.parse('$baseUrl/api_detail.html'),
        body: body,
      );
      // debugPrint('detail request = ${response.request.toString()}');
      debugPrint('detail body = ${body.toString()}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = jsonDecode(response.body);
        detailDataInstance =
            DetailData.fromJson(json: jsonBody, arguPageType: pageType);
        return detailDataInstance;
      } else {
        return DetailData(
          message: '네트워크 상태가 불안하오니\n잠시후에 이용해주십시오\n상태가 지속되면 관리자에게 문의주시길 바랍니다.',
        );
      }
    } catch (e) {
      return DetailData(
        message: '알수없는 오류가 발생하였습니다\n상태가 지속되면 관리자에게 문의주시길 바랍니다.',
      );
    }
  }

  static Future<ListData> getListData({
    required String pageType,
    int ca = 0,
    int cursor = 0,
    int s_cur = 0,
    int p_uid = 0,
    int e_uid = 0,
  }) async {
    ListData listInstance;

    try {
      final body = {
        'type': pageType,
        'ca': ca.toString(),
        'cursor': cursor.toString(),
        's_cur': s_cur.toString(),
        'p_uid': p_uid.toString(),
        'e_uid': e_uid.toString(),
        'app_key': appKey,
        'sign_key': encryptedText,
        'sign_type': 'app',
      };
      //debugPrint('body = ${body.toString()}');
      final response = await http.post(
        Uri.parse('$baseUrl/api_list.html'),
        body: body,
      );

      //debugPrint('request = ${response.request.toString()}');
      //debugPrint('body = ${body.toString()}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = jsonDecode(response.body);
        listInstance =
            ListData.fromJson(json: jsonBody, arguPageType: pageType);
        //debugPrint('cases = ${listInstance.rows}');
        //int totalRows = listInstance.rows?.length ?? 0;
        return listInstance;
      } else {
        return ListData(
          message: '네트워크 상태가 불안하오니\n잠시후에 이용해주십시오\n상태가 지속되면 관리자에게 문의주시길 바랍니다.',
        );
        //throw Error();
      }
    } catch (e) {
      return ListData(
        message: '알수없는 오류가 발생하였습니다\n상태가 지속되면 관리자에게 문의주시길 바랍니다.',
      );
    }
  }
}
