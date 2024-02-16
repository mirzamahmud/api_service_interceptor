import 'dart:convert';

import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// -------- [main] function ----------------------
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependency();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  runApp(const MyApp());
}

/// ----- [MaterialApp] ---------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: LoginBinding(),
      home: const LoginScreen(),
    );
  }
}

/// ---------------- [LoginScreen] --------------------
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<LoginController>(builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Username',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: controller.emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a username .";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter your username',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            height: 1.0,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Password',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: controller.passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password Field Not Be Empty";
                          } else {
                            return null;
                          }
                        },
                        obscureText: !controller.showPassword,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                          ),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () => controller.passwordVisibility(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        controller.signInUser();
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 24, vertical: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12)),
                      child: controller.isSubmit
                          ? const SizedBox(
                              height: 14,
                              width: 14,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ))
                          : const Text("Continue"),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

/// ------------- [LoginBinding] --------------------

class LoginBinding extends Bindings {
  LoginBinding();

  @override
  void dependencies() {
    Get.lazyPut(() => LoginRepo(apiServiceInterceptor: Get.find()));
    Get.lazyPut(() => LoginController(loginRepo: Get.find()));
  }
}

/// ------------ [LoginController] ------------------

class LoginController extends GetxController {
  final LoginRepo loginRepo;
  LoginController({required this.loginRepo});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;
  bool isSubmit = false;

  Future<void> signInUser() async {
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await loginRepo.loginUser(
        username: emailController.text.trim(),
        password: passwordController.text.trim());

    if (responseModel.statusCode == 200) {
      LoginResponseModel loginResponseModel =
          LoginResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      await loginRepo.apiServiceInterceptor.sharedPreferences
          .setString("accessTokenKey", loginResponseModel.token ?? "");

      if (kDebugMode) {
        print("Login Successfully");
      }
    } else {
      if (responseModel.statusCode == 401) {
        // error message
      } else if (responseModel.statusCode == 404) {
        // error message
      } else {
        // error message
      }
    }

    isSubmit = false;
    update();
  }

  // password visibility method
  void passwordVisibility() {
    showPassword = !showPassword;
    update();
  }
}

/// ------------- [LoginRepo] ----------------

class LoginRepo {
  final ApiServiceInterceptor apiServiceInterceptor;
  LoginRepo({required this.apiServiceInterceptor});

  Future<ApiResponseModel> loginUser(
      {required String username, required String password}) async {
    String url = "------- pass your api url -------";

    Map<String, String> bodyParams = {
      "username": username,
      "password": password
    };

    Map<String, String> headers = {'Content-Type': 'application/json'};

    ApiResponseModel responseModel =
        await apiServiceInterceptor.requestToServer(
            requestUrl: url,
            requestMethod: ApiRequestMethod.postMethod,
            bodyParams: jsonEncode(bodyParams),
            headers: headers);

    return responseModel;
  }
}

/// ---------- [LoginResponseModel] ------------

class LoginResponseModel {
  String? _token;

  LoginResponseModel({String? token}) {
    if (token != null) {
      _token = token;
    }
  }

  String? get token => _token;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    _token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = _token;
    return data;
  }
}

/// ---------- dependency inject -------------------
Future<void> initDependency() async {
  final sharedPreference = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreference, fenix: true);
  Get.lazyPut(() => ApiServiceInterceptor(sharedPreferences: Get.find()),
      fenix: true);
}
