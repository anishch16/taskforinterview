import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';
import 'model.dart';

class ViewModel extends GetxController {
  var contentData = Album().obs;
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAlbum();
  }
  Future<void> fetchAlbum() async {
    loading.value = true;
    var response = await http.get(Uri.parse(Api.url));
    if (response.statusCode == 200)  {
      Album contentResponse = Album.fromJson(jsonDecode(response.body));
      contentData.value = Album(
        message: contentResponse.message,
        status: contentResponse.status,
      );
      loading.value = false;
    } else {
      Get.snackbar(
        "Error",
        "Error Fetching the data",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        icon: const Icon(Icons.add_alert),
      );
    }
  }
}
