import 'dart:convert';

import 'package:myapp/API/APIParser.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class APIService {
  static const String baseUrl =
      "http://ec2-3-27-181-63.ap-southeast-2.compute.amazonaws.com:8080";
  static const String category = "category";
  static const String jobs = "jobs";

  static const String apiInitData = "hong/{hongId}";
  static const String apiMain = "app/main";
  static const String contentDetail = "content/detail";

  static Map<String, String> header = {
    'CONTENT-TYPE': "application/json",
    'SID': "211104651382",
    'OS-INFO': "android_10",
    'DEVICE-MODEL': "uie4027lgu",
    'DEVICE-INFO': "STB",
    'NW-INFO': "WIRE",
    'CARRIER-TYPE': "E",
    'AUTHORIZATION': "",
    'PROFILE_KEY': "0",
    'APP_VER': "1.3.2",
  };

  // BaseOptions options = BaseOptions(
  //   baseUrl: baseUrl,
  //   connectTimeout: 3000,
  //   receiveTimeout: 3000,
  // );

  static Future<Category> GetCategory() async {
    // final url = Uri.parse('$baseUrl/$category');
    // final response = await http.get(url, headers: header);

    Dio dio = Dio();

    final response = await dio.get('$baseUrl/$category');
    // print(response.statusCode);
    if (response.statusCode == 200) {
      // final jsonData = jsonDecode(response.data);
      Category category = Category.fromJson(response.data);
      return category;
    }

    throw Error();
  }

  static Future<Jobs> GetJobs() async {
    // final url = Uri.parse('$baseUrl/$jobs');
    // final response = await http.get(url, headers: header);

    Dio dio = Dio();
    final response = await dio.get('$baseUrl/$jobs');

    if (response.statusCode == 200) {
      // final jsonData = jsonDecode(response.body);
      Jobs jobs = Jobs.fromJson(response.data);

      // test
      Job job = GetJob(jobs.data[0].jobId) as Job;
      print(job.content);
      return jobs;
    }

    throw Error();
  }

  static Future<Job> GetJob(int hongId) async {
    // final url = Uri.parse('$baseUrl/$jobs');
    // final response = await http.get(url, headers: header);
    // http://ec2-3-27-181-63.ap-southeast-2.compute.amazonaws.com:8080/jobs/hong/{hongId}

    Dio dio = Dio();
    final response = await dio.get('$baseUrl/$jobs/hong/$hongId');

    if (response.statusCode == 200) {
      // final jsonData = jsonDecode(response.body);
      Job job = Job.fromJson(response.data);
      return job;
    }

    throw Error();
  }

  static void PostJob(int categoryId, String content, String timestamp, int memberId, int silverId, String requestAddress) async {
    // final url = Uri.parse('$baseUrl/$jobs');
    // final response = await http.get(url, headers: header);
    // http://ec2-3-27-181-63.ap-southeast-2.compute.amazonaws.com:8080/jobs/hong/{hongId}

    var formData = FormData.fromMap({
      "categoryId": 1,
      "content": "도움이 필요해요",
      "timestamp": "2023-09-01T00:29:05.000+00:00",
      "memberId": 2,
      "silverId": 2,
      "requestAddress": "서울 어딘가"
    });

    Dio dio = Dio();
    final response = await dio.post('$baseUrl/$jobs', data: formData);

    print(response.statusCode);
    if (response.statusCode == 200) {
      // final jsonData = jsonDecode(response.body);
      // Job job = Job.fromJson(response.data);
      // return job;
    }

    throw Error();
  }
}