// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:impactlyflutter/Constant/url.dart';
import 'package:impactlyflutter/Services/ServicesProvider.dart';
<<<<<<< HEAD
import 'package:impactlyflutter/Controller/LocaleController.dart';
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836

enum RequestType { GET, POST, PUT, DELETE }

enum RequestTypeImage { POST_WITH_IMAGE, POST_WITH_MULTI_IMAGE }

class NetworkClient {
  static final String _baseUrl = AppApi.url;

  final http.Client _client;
  final ServicesProvider _services;
<<<<<<< HEAD
  final LocaleController _localeController;

  NetworkClient(this._client, this._services, this._localeController);

  Map<String, String> _getHeaders({bool withtoken = false}) {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Language': _localeController.locale.languageCode,
    };

    if (withtoken) {
      headers['Authorization'] = 'Bearer ${_services.token}';
    }

    return headers;
  }
=======

  NetworkClient(this._client, this._services);
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836

  Future<StreamedResponse> requestwithfile({
    required String path,
    Map<String, String>? body,
    bool withfile = false,
    http.MultipartFile? file,
  }) async {
<<<<<<< HEAD
    var req =
        http.MultipartRequest("PUT", Uri.parse('$_baseUrl$path'))
          ..fields.addAll(body!)
          ..headers.addAll({..._getHeaders(withtoken: true)});

    if (withfile && file != null) {
      req.files.add(file);
    }

    return await req.send();
=======
    log(_services.token);
    var req =
        http.MultipartRequest("PUT", Uri.parse('$_baseUrl$path'))
          ..fields.addAll(body!)
          ..headers.addAll({
            "Accept": "application/json",
            'Authorization': 'Bearer ${_services.token}',
          });
    if (withfile) {
      req.files.add(file!);
    }

    var res = await req.send();
    return res;
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
  }

  Future<http.StreamedResponse> requestwithmultifile({
    required String path,
    Map<String, String>? body,
    required List<http.MultipartFile> files,
    required RequestType requestType,
  }) async {
    late final http.MultipartRequest req;

    switch (requestType) {
      case RequestType.PUT:
        req = http.MultipartRequest("PUT", Uri.parse('$_baseUrl$path'));
        break;
<<<<<<< HEAD
      case RequestType.POST:
        req = http.MultipartRequest("POST", Uri.parse('$_baseUrl$path'));
        break;
=======

      case RequestType.POST:
        req = http.MultipartRequest("POST", Uri.parse('$_baseUrl$path'));
        break;

>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
      default:
        throw Exception("Unsupported request type");
    }

    if (body != null) {
      req.fields.addAll(body);
    }

<<<<<<< HEAD
    req.headers.addAll(_getHeaders(withtoken: true));
    req.files.addAll(files);

    return await req.send();
=======
    req.headers.addAll({
      "Accept": "application/json",
      'Authorization': 'Bearer ${_services.token}',
    });

    req.files.addAll(files);

    final response = await req.send();
    return response;
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
  }

  Future<Response> request({
    required RequestType requestType,
    required String path,
    bool withtoken = false,
<<<<<<< HEAD
    bool pagination = false,
    String? body,
    int timeout = 60,
=======
    bool pageination = false,

    String? body,
    int TimeOut = 60,
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
  }) async {
    log("$_baseUrl$path");
    log(_services.token);

<<<<<<< HEAD
    final uri = Uri.parse(pagination ? path : '$_baseUrl$path');
    final headers = _getHeaders(withtoken: withtoken);

    switch (requestType) {
      case RequestType.GET:
        return _client
            .get(uri, headers: headers)
            .timeout(Duration(seconds: timeout));
      case RequestType.POST:
        return _client
            .post(uri, headers: headers, body: body)
            .timeout(Duration(seconds: timeout));
      case RequestType.PUT:
        return _client
            .put(uri, headers: headers, body: body)
            .timeout(Duration(seconds: timeout));
      case RequestType.DELETE:
        return _client
            .delete(uri, headers: headers, body: body)
            .timeout(Duration(seconds: timeout));
=======
    switch (requestType) {
      case RequestType.GET:
        return _client
            .get(
              Uri.parse(pageination ? "$path" : "$_baseUrl$path"),

              headers:
                  withtoken
                      ? {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer ${_services.token}',
                      }
                      : {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json',
                      },
            )
            .timeout(Duration(seconds: TimeOut));
      case RequestType.POST:
        return _client
            .post(
              Uri.parse("$_baseUrl$path"),
              headers:
                  withtoken
                      ? {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer ${_services.token}',
                      }
                      : {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json',
                      },
              body: body,
            )
            .timeout(Duration(seconds: TimeOut));
      case RequestType.PUT:
        return _client
            .put(
              Uri.parse("$_baseUrl$path"),
              headers:
                  withtoken
                      ? {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer ${_services.token}',
                      }
                      : {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json',
                      },
              body: body,
            )
            .timeout(Duration(seconds: TimeOut));
      case RequestType.DELETE:
        return _client
            .delete(
              Uri.parse("$_baseUrl$path"),
              headers:
                  withtoken
                      ? {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer ${_services.token}',
                      }
                      : {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json',
                      },
              body: body,
            )
            .timeout(Duration(seconds: TimeOut));
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
    }
  }
}
