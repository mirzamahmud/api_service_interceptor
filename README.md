## api_service_interceptor

Api Service interceptor is a Flutter package that helps you to fetch and pass data from Server within the easiest way.

## API Service Interceptor

[![pub package](https://img.shields.io/pub/v/api_service_interceptor?include_prereleases)](https://pub.dartlang.org/packages/api_service_interceptor)
[![popularity](https://img.shields.io/pub/popularity/api_service_interceptor?logo=dart)](https://pub.dev/packages/api_service_interceptor/score)
[![likes](https://img.shields.io/pub/likes/api_service_interceptor?logo=dart)](https://pub.dev/packages/api_service_interceptor/score)
[![pub points](https://img.shields.io/pub/points/sentry?logo=dart)](https://pub.dev/packages/api_service_interceptor/score)
[![GH Actions](https://github.com/juliuscanute/qr_code_scanner/workflows/dart/badge.svg)](https://github.com/mirzamahmud/api_service_interceptor/actions)
[![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://pub.dev/packages/effective_dart)
<a href="https://github.com/Solido/awesome-flutter">
<img alt="Awesome Flutter" src="https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true&style=flat-square" />
</a>

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

`ApiServiceInterceptor` class has two types of method
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

Another, we have a `ApiResponseModel` class. This class has two field [_statusCode] and [_responseJson]. 
- [_statusCode] store what type of status we get from the server and it is an `Int` type. 
- [_responseJson] store which response we get from the server and it is `String` type.
Usually `ApiResponseModel` is the skeleton of data which we get from Server Response. 

On the other hand, we have an `enums` class called `ApiRequestMethod`. From this enums we will get our possible [requestMethod].
Basically `enums`, are a special kind of class used to represent a fixed number of constant values.

## Usage

```dart

/// declare ApiServiceInterceptor
final ApiServiceInterceptor apiServiceInterceptor;

/// store data ApiResponseModel
ApiResponseModel responseModel = apiServiceInterceptor.requestToServer(
  requestUrl: "---------- use your api url ----------",
  requestMethod: ApiRequestMethod.postRequest, /// use ApiRequestMethod to send request to Server.
  bodyParams: jsonEncode({
    "username": username,
    "password": password
  }),
  headers: {'Content-Type': 'application/json'}
);

```
## Additional Information

This package is built on "http", "http_parser" and "shared_preferences". When we use "api_service_interceptor" package than we also use "shared_preferences" package.
