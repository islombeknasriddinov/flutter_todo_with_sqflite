import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gwslib/log/logger.dart';

class Network {
  static bool _debugMode = false;

  static void enableDebugMode() {
    _debugMode = true;
  }

  static Network _instance;

  static Network _getInstance() {
    if (_instance == null) {
      Dio dio = Dio();
      dio.options.connectTimeout = 10 * 1000;
      if (_debugMode) {
        dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
      }
      _instance = Network(dio);
    }
    return _instance;
  }

  final Dio _dio;

  Network(this._dio);

  static _NetworkBuilder post(String url, String uri) {
    final _url = url.endsWith("/") ? url : "$url/";
    final _uri = uri.startsWith("/") ? uri.substring(1) : uri;
    return _NetworkBuilder(_url, _uri, "POST");
  }

  static _NetworkBuilder get(String url, String uri) {
    final _url = url.endsWith("/") ? url : "$url/";
    final _uri = uri.startsWith("/") ? uri.substring(1) : uri;
    return _NetworkBuilder(_url, _uri, "GET");
  }

  Future<String> _go(_NetworkBuilder builder) async {
    String uniqueValue = builder.unique();
    Log.debug("======================\n$uniqueValue\n======================");

    dynamic data = {};
    if (builder._files.isNotEmpty) {
      final paramBody = builder._body is String ? builder._body : json.encode(builder._body ?? {});
      data = FormData.fromMap({"param": paramBody, "files": builder._files});
    } else if (builder._body != null) {
      data = builder._body;
    }
    final Response<String> _result = await _dio.request(builder.uri,
        queryParameters: builder._param,
        options: RequestOptions(
          method: builder.method,
          headers: builder._header,
          baseUrl: builder.url,
        ),
        data: data);

    return _result.data;
  }
}

class _NetworkBuilder {
  final String url;
  final String uri;
  final String method;

  final Map<String, String> _param = {};
  final Map<String, String> _header = {};
  final List<MultipartFile> _files = [];

  dynamic _body;

  _NetworkBuilder(this.url, this.uri, this.method);

  String unique() {
    if (_files.isEmpty) {
      String value = "$url$uri";

      final params = (_param.keys.toList()..sort((l, r) => l.compareTo(r)))
          .map((k) => "$k-${_param[k]}")
          .join(",");

      final headers = (_header.keys.toList()..sort((l, r) => l.compareTo(r)))
          .map((k) => "$k-${_header[k]}")
          .join(",");

      String bodyValue = _body is String ? _body : json.encode(_body);
      return ([value, params, headers, bodyValue]..removeWhere((e) => e.isEmpty)).join(",").trim();
    } else {
      return DateTime.now().millisecondsSinceEpoch.toString();
    }
  }

  _NetworkBuilder param(String key, String value) {
    ArgumentError.checkNotNull(key, 'key');
    ArgumentError.checkNotNull(value, 'value');
    _param[key] = value;
    return this;
  }

  _NetworkBuilder headerToken(String token) {
    return header("token", token);
  }

  _NetworkBuilder header(String key, String value) {
    ArgumentError.checkNotNull(key, 'key');
    ArgumentError.checkNotNull(value, 'value');
    _header[key] = value;
    return this;
  }

  _NetworkBuilder body(dynamic body) {
    ArgumentError.checkNotNull(body, 'body');
    if (_body != null) {
      print("=================================\n" +
          "$uri BODY CHANGES\n" +
          "$_body TO $body\n" +
          "=================================");
    }

    if (body is Map) {
      final _data = <String, dynamic>{};
      _data.addAll(body);
      _data.removeWhere((key, value) => value == null);
      _body = _data;
    } else if (body is List) {
      _body = body;
    } else if (body is String) {
      _body = body;
    } else {
      _body = body.toJson();
    }
    return this;
  }

  _NetworkBuilder file(MultipartFile file) {
    ArgumentError.checkNotNull(file, 'file');
    header("BiruniUpload", "param");
    _files.add(file);
    return this;
  }

  _NetworkBuilder files(List<MultipartFile> files) {
    ArgumentError.checkNotNull(files, 'files');
    if (_files.isNotEmpty) {
      print("=================================\n" +
          "${_files.length} FILES CHANGES\n" +
          "${_files.length} TO ${files.length}" +
          "=================================");
      _files.clear();
    }
    files.forEach((it) => file(it));
    return this;
  }

  Future<String> go() async {
    return Network._getInstance()._go(this);
  }
}
