## api_service_interceptor

A Flutter package that will help for fetching and passing data to the server.

## API Service Interceptor

[![pub package](https://img.shields.io/pub/v/api_service_interceptor?include_prereleases)](https://pub.dartlang.org/packages/api_service_interceptor)

## How ApiServiceInterceptor Works

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

## Usage

```dart

final ApiServiceInterceptor apiServiceInterceptor;

Future<ApiResponseModel> loginUser(
      {required String email, required String password}) async {

    String url = "-------- use your api url ---------";

    Map<String, String> bodyParams = {
      "email": email,
      "password": password
    };

    Map<String, String> headers = {'Content-Type': 'application/json'};

    ApiResponseModel responseModel = await apiServiceInterceptor.requestToServer(
        requestUrl: url,
        requestMethod: "Post",
        bodyParams: jsonEncode(bodyParams),
        headers: headers
    );

    return responseModel;
}

```
## Additional Information

This package is built on "http", "http_parser" and "shared_preferences". When we use "api_service_interceptor" package than we also use "shared_preferences" package.
