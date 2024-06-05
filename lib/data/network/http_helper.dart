import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';

import '../../app/utils/global.dart';
import '../exceptions/authentication_exception.dart';
import 'constants.dart';

class HttpHelper {
  /// Invokes an `http` request given.
  /// [url] can either be a `string` or a `Uri`.
  /// The [type] can be any of the [RequestType]s.
  /// [body] and [encoding] only apply to [RequestType.post] and [RequestType.put] requests. Otherwise,
  /// they have no effect.
  /// This is optimized for requests that anticipate a response body of type `Map<String, dynamic>`, as in a json file-type response.
  static Future<Map<String, dynamic>?> invokeHttp(dynamic url, RequestType type,
      {Map<String, String>? headers, dynamic body}) async {
    http.Response response;
    Map<String, dynamic>? responseBody;
    try {
      response = await _invoke(
        url,
        type,
        headers: getHeaders(headers, url),
        body: body,
      );
    } catch (error) {
      rethrow;
    }
    if (response.body.isEmpty) return null;
    responseBody = jsonDecode(response.body);
    return responseBody;
  }

  /// Invokes an `http` request given.
  /// [url] can either be a `string` or a `Uri`.
  /// The [type] can be any of the [RequestType]s.
  /// [body] and [encoding] only apply to [RequestType.post] and [RequestType.put] requests. Otherwise,
  /// they have no effect.
  /// This is optimized for requests that anticipate a response body of type `Map<String, dynamic>`, as in a json file-type response.
  static Future<List<dynamic>?> invokeHttpList(dynamic url, RequestType type,
      {Map<String, String>? headers, dynamic body}) async {
    http.Response response;
    List<dynamic>? responseBody;
    try {
      response = await _invoke(
        url,
        type,
        headers: getHeaders(headers, url),
        body: body,
      );
    } catch (error) {
      rethrow;
    }
    if (response.body.isEmpty) return null;
    responseBody = jsonDecode(response.body);
    return responseBody;
  }

  /// Invokes an `http` request given.
  /// [url] can either be a `string` or a `Uri`.
  /// The [type] can be any of the [RequestType]s.
  /// [body] and [encoding] only apply to [RequestType.post] and [RequestType.put] requests. Otherwise,
  /// they have no effect.
  /// This is optimized for requests that anticipate a response body of type `Map<String, dynamic>`, as in a json file-type response.
  static Future<List<dynamic>?> invokeFile(
      dynamic url, RequestType type, List<String> filePaths,
      {Map<String, String>? headers, dynamic body}) async {
    http.Response response;
    List<dynamic>? responseBody;

    try {
      List<http.MultipartFile> files = [];
      for (var path in filePaths) {
        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
            'files', path.replaceAll('file://', ''),
            contentType: MediaType("audio", "mpeg"));
        files.add(multipartFile);
        debugPrint(
            "MULTIPARTFILE:  files${path.replaceAll('file://', '')}${files[0].contentType}");
      }
      response = await _invokeFile(
        url,
        type,
        files,
        headers: getHeadersUploadFile(headers),
        body: body,
      );
    } catch (error) {
      rethrow;
    }
    if (response.body.isEmpty) return null;
    responseBody = jsonDecode(response.body);
    return responseBody;
  }

  /// Invokes an `http` request given.
  /// [url] can either be a `string` or a `Uri`.
  /// The [type] can be any of the [RequestType]s.
  /// [body] and [encoding] only apply to [RequestType.post] and [RequestType.put] requests. Otherwise,
  /// they have no effect.
  /// This is optimized for requests that anticipate a response body of type `Map<String, dynamic>`, as in a json file-type response.
  static Future<Map<String, dynamic>?> invokeSingleFile(
      dynamic url, RequestType type, String filePaths,
      {Map<String, String>? headers, dynamic body}) async {
    http.Response response;
    Map<String, dynamic> responseBody;

    try {
      http.MultipartFile files;

      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('files', filePaths);
      files = multipartFile;

      response = await _invokeSingleFile(
        url,
        type,
        files,
        headers: getHeadersUploadFile(headers),
        body: body,
      );
    } catch (error) {
      rethrow;
    }
    if (response.body.isEmpty) return null;
    responseBody = jsonDecode(response.body);
    return responseBody;
  }

  static Map<String, String> getHeaders(
      Map<String, String>? headers, dynamic url) {
    Map<String, String>? customizeHeaders;
    if (headers != null) {
      customizeHeaders = headers;
    } else {
      customizeHeaders = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "platform": Platform.isIOS ? "IOS" : "ANDROID",
        "deviceAppVer": Global.appVersion,
        "lang": Global.mLang
      };
    }
    return customizeHeaders;
  }

  static Map<String, String> getHeadersUploadFile(
      Map<String, String>? headers) {
    Map<String, String>? customizeHeaders;
    if (headers != null) {
      customizeHeaders = headers;
    } else {
      customizeHeaders = {
        "Accept": "*/*",
        "Content-Type": "multipart/form-data"
      };
    }
    return customizeHeaders;
  }

  /// Invokes an `http` request given.
  /// [url] can either be a `string` or a `Uri`.
  /// The [type] can be any of the [RequestType]s.
  /// [body] and [encoding] only apply to [RequestType.post] and [RequestType.put] requests. Otherwise,
  /// they have no effect.
  /// This is optimized for requests that anticipate a response body of type `List<dynamic>`, as in a list of json objects.
  static Future<List<dynamic>> invokeHttp2(dynamic url, RequestType type,
      {Map<String, String>? headers, dynamic body}) async {
    http.Response response;
    List<dynamic> responseBody;
    try {
      response = await _invoke(url, type, headers: headers, body: body);
    } on SocketException {
      rethrow;
    }

    responseBody = jsonDecode(response.body);
    return responseBody;
  }

  /// Invoke the `http` request, returning the [http.Response] unparsed.
  static Future<http.Response> _invoke(dynamic url, RequestType type,
      {Map<String, String>? headers, dynamic body}) async {
    if (!Global.isDisableHttpLogging) {
      debugPrint("Http: >>>>");
      debugPrint("Http: Request Url: $url");
      debugPrint("Http: Request Method: ${type.name.toUpperCase()}");
      debugPrint("Http: Request Header: ${headers.toString()}");
      debugPrint(
          "Http: Request Time: ${DateFormat("dd MMMM yyyy HH:mm:ss").format(DateTime.now())}");
      debugPrint(
          "Http: Request body: ${body == null ? "EMPTY" : body.toString()}");
      debugPrint("Http: >>>>");
    }
    http.Response response;

    try {
      switch (type) {
        case RequestType.get:
          response = await http.get(url, headers: headers);
          break;
        case RequestType.post:
          response = await http.post(url, headers: headers, body: body);
          break;
        case RequestType.put:
          response = await http.put(url, headers: headers, body: body);
          break;
        case RequestType.delete:
          response = await http.delete(url, headers: headers);
          break;
      }
      if (!Global.isDisableHttpLogging) {
        debugPrint("Http: <<<<");
        debugPrint("Http: Response for Url: ${response.statusCode} - $url");
        debugPrint(
            "Http: Response time: ${DateFormat("dd MMMM yyyy HH:mm:ss").format(DateTime.now())}");
        debugPrint(
            "Http: Response: ${response.body.isEmpty ? "EMPTY" : const JsonEncoder.withIndent(' ').convert(jsonDecode(response.body.toString()))}");
        debugPrint("Http: <<<<");
      }
      // check for any errors
      if (!successStatusCodeList.contains(response.statusCode)) {
        Map<String, dynamic> body = jsonDecode(response.body);
        if (response.statusCode == 500) {
          try {
            String error = "";
            if (body['error'] != null) {
              error = body['error'];
            } else if (body['message'] != null) {
              error = body['message'];
            }
            throw APIException(error, response.statusCode, null);
          } catch (e) {
            String error = "";
            if (body['error'] != null) {
              error = body['error'];
            } else if (body['message'] != null) {
              error = body['message'];
            }
            throw APIException(error, response.statusCode, null);
          }
        } else {
          String error = "";
          if (body['error'] != null) {
            error = body['error'];
          } else if (body['message'] != null) {
            error = body['message'];
          }
          throw APIException(error, response.statusCode, null);
        }
      }
      return response;
    } on http.ClientException {
      // handle any 404's
      rethrow;
      // handle no internet connection
    } on SocketException catch (e) {
      throw Exception(e.osError?.message);
    } catch (error) {
      rethrow;
    }
  }

  /// Invoke the `http` request, returning the [http.Response] unparsed.
  static Future<http.Response> _invokeFile(
      dynamic url, RequestType type, List<http.MultipartFile> filePaths,
      {Map<String, String>? headers, dynamic body}) async {
    if (!Global.isDisableHttpLogging) {
      debugPrint("Http: >>>>");
      debugPrint("Http: Request Url: $url");
      debugPrint("Http: Request Method: ${type.name.toUpperCase()}");
      debugPrint("Http: Request Header: ${headers.toString()}");
      debugPrint(
          "Http: Request Time: ${DateFormat("dd MMMM yyyy HH:mm:ss").format(DateTime.now())}");
      debugPrint(
          "Http: Request body: ${body == null ? "EMPTY" : body.toString()}");
      debugPrint("Http: >>>>");
    }

    http.Response response;

    try {
      http.MultipartRequest request =
          http.MultipartRequest(type.name.toUpperCase(), url);
      if (headers != null) {
        request.headers.addAll(headers);
      }
      request.files.addAll(filePaths);
      http.StreamedResponse streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);

      if (!Global.isDisableHttpLogging) {
        debugPrint("Http: <<<<");
        debugPrint("Http: Response for Url: ${response.statusCode} - $url");
        debugPrint(
            "Http: Response time: ${DateFormat("dd MMMM yyyy HH:mm:ss").format(DateTime.now())}");
        debugPrint(
            "Http: Response: ${response.body.isEmpty ? "EMPTY" : const JsonEncoder.withIndent(' ').convert(jsonDecode(response.body.toString()))}");
        debugPrint("Http: <<<<");
      }
      // check for any errors
      if (!successStatusCodeList.contains(response.statusCode)) {
        Map<String, dynamic> body = jsonDecode(response.body);
        if (response.statusCode == 500) {
          try {
            String error = "";
            if (body['error'] != null) {
              error = body['error'];
            } else if (body['message'] != null) {
              error = body['message'];
            }
            throw APIException(error, response.statusCode, null);
          } catch (e) {
            String error = "";
            if (body['error'] != null) {
              error = body['error'];
            } else if (body['message'] != null) {
              error = body['message'];
            }
            throw APIException(error, response.statusCode, null);
          }
        } else {
          String error = "";
          if (body['error'] != null) {
            error = body['error'];
          } else if (body['message'] != null) {
            error = body['message'];
          }
          throw APIException(error, response.statusCode, null);
        }
      }
      return response;
    } on http.ClientException {
      // handle any 404's
      rethrow;

      // handle no internet connection
    } on SocketException catch (e) {
      throw Exception(e.osError?.message);
    } catch (error) {
      rethrow;
    }
  }

  /// Invoke the `http` request, returning the [http.Response] unparsed.
  static Future<http.Response> _invokeSingleFile(
      dynamic url, RequestType type, http.MultipartFile filePaths,
      {Map<String, String>? headers, dynamic body}) async {
    if (!Global.isDisableHttpLogging) {
      debugPrint("Http: >>>>");
      debugPrint("Http: Request Url: $url");
      debugPrint("Http: Request Method: ${type.name.toUpperCase()}");
      debugPrint("Http: Request Header: ${headers.toString()}");
      debugPrint(
          "Http: Request Time: ${DateFormat("dd MMMM yyyy HH:mm:ss").format(DateTime.now())}");
      debugPrint(
          "Http: Request body: ${body == null ? "EMPTY" : body.toString()}");
      debugPrint("Http: >>>>");
    }

    http.Response response;

    try {
      http.MultipartRequest request =
          http.MultipartRequest(type.name.toUpperCase(), url);
      if (headers != null) {
        request.headers.addAll(headers);
      }
      request.files.add(filePaths);
      http.StreamedResponse streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);

      if (!Global.isDisableHttpLogging) {
        debugPrint("Http: <<<<");
        debugPrint("Http: Response for Url: ${response.statusCode} - $url");
        debugPrint(
            "Http: Response time: ${DateFormat("dd MMMM yyyy HH:mm:ss").format(DateTime.now())}");
        debugPrint(
            "Http: Response: ${response.body.isEmpty ? "EMPTY" : const JsonEncoder.withIndent(' ').convert(jsonDecode(response.body.toString()))}");
        debugPrint("Http: <<<<");
      }
      // check for any errors
      if (!successStatusCodeList.contains(response.statusCode)) {
        Map<String, dynamic> body = jsonDecode(response.body);
        if (response.statusCode == 500) {
          try {
            String error = "";
            if (body['error'] != null) {
              error = body['error'];
            } else if (body['message'] != null) {
              error = body['message'];
            }
            throw APIException(error, response.statusCode, null);
          } catch (e) {
            String error = "";
            if (body['error'] != null) {
              error = body['error'];
            } else if (body['message'] != null) {
              error = body['message'];
            }
            throw APIException(error, response.statusCode, null);
          }
        } else {
          String error = "";
          if (body['error'] != null) {
            error = body['error'];
          } else if (body['message'] != null) {
            error = body['message'];
          }
          throw APIException(error, response.statusCode, null);
        }
      }
      return response;
    } on http.ClientException {
      // handle any 404's
      rethrow;

      // handle no internet connection
    } on SocketException catch (e) {
      throw Exception(e.osError?.message);
    } catch (error) {
      rethrow;
    }
  }
}

// types used by the helper
enum RequestType { get, post, put, delete }
