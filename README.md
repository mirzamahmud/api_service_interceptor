## api_service_interceptor

A Flutter package that will help for fetching and passing data to the server.

## API Service Interceptor

[![pub package](https://img.shields.io/pub/v/api_service_interceptor?include_prereleases)](https://pub.dartlang.org/packages/api_service_interceptor)

## How It Works

![ezgif com-animated-gif-maker](https://github.com/mirzamahmud/api_service_interceptor/assets/91328350/1b54a07f-8b72-4d80-b662-d5157c955fbe)

## Installation

Add dependency for package on your pubspec.yaml:

```yaml
    dependencies:
      api_service_interceptor: latest
```
or

```shell
flutter pub add api_service_interceptor
```

## Features

ApiServiceInterceptor class has two types of method
- requestToServer()
- multipartRequestToServer()

First describe the "requestToServer()" method. This method takes four parameters ->

| Parameters                       | Definitions                                                                                                                                                                                                                                                              |
|----------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `String requestUrl`              | (Required) need to pass your API's url.                                                                                                                                                                                                                                  |
| `ApiRequestMethod requestMethod` | (Required) need to pass API's method so that server can understand for which type of response data you want.                                                                                                                                                             | 
| `Object? bodyParams`             | (Optional) sets the body of the request. It can be a [String], a [List] or a [Map<String, String>]                                                                                                                                                                       |
| `Map<String, String>? headers`   | (Optional) need to pass headers because it helps you contain more information about the resource to be fetched, or about the client requesting the resource and also hold additional information about the response, like its location or about the server providing it. |

now describe the "multipartRequestToServer()" method, and this method takes seven parameters ->

| Parameters                   | Definitions                                                                                                                                                                                                                                                               
|------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `String requestUrl`          | (Required) need to pass your API's url.                                                                                                                                                                                                                                   |
| `String requestMethod`       | (Required) need to pass API's method so that server can understand for which type of response data you want.                                                                                                                                                              |
| `Map<String, String> headers` | (Required) need to pass headers because it helps you contain more information about the resource to be fetched, or about the client requesting the resource and also hold additional information about the response, like its location or about the server providing it.  |
| `String multipartFileField`  | (Required) the name of the form field for the file                                                                                                                                                                                                                        |
| `String multipartFileValue`  | (Required) encoding to use when translating [multipartFileValue] into bytes is taken from [multipartContentType] if it has a charset set. Otherwise, it defaults to UTF-8.                                                                                                |
| `String multipartFileName`   | (Optional) The basename of the file, and it may be `null`                                                                                                                                                                                                                 |
| `MediaType multipartContentType`   | (Optional) The content-type of the file, and Defaults to `application/octet-stream`                                                                                                                                                                                                                 |

## Usage

```dart

final ApiServiceInterceptor apiServiceInterceptor;

Future<ApiResponseModel> loginUser(
    {required String username, required String password}) async {
  String url = "---------- use your api url ----------";

  Map<String, String> bodyParams = {
    "username": username,
    "password": password
  };

  Map<String, String> headers = {'Content-Type': 'application/json'};

  ApiResponseModel responseModel =
  await apiServiceInterceptor.requestToServer(
      requestUrl: url,
      requestMethod: ApiRequestMethod.postRequest,
      bodyParams: jsonEncode(bodyParams),
      headers: headers);

  return responseModel;
}

```
## Additional Information

This package is built on "http", "http_parser" and "shared_preferences". When we use "api_service_interceptor" package than we also use "shared_preferences" package.
