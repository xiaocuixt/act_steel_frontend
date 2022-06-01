import 'package:act_steel_frontend/views/home_page.dart';
import 'package:act_steel_frontend/views/main_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:act_steel_frontend/graphql/gql_users.dart';
import 'package:act_steel_frontend/services/graphql_conf.dart';
import 'package:act_steel_frontend/components/utils.dart';
import 'package:act_steel_frontend/services/storage.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:act_steel_frontend/services/login_info.dart';

class LoginUser extends StatefulWidget {
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  @override
  Widget build(BuildContext context) {
    TextEditingController accountController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final loginInfo = LoginInfo();
    return GraphQLProvider(
      client: GraphqlConf.initGraphqlClient(loginInfo.token),
      child: Scaffold(
        body: Mutation(
          options: MutationOptions(
            document: gql(GqlUsers.loginUser),
            onError: (dynamic resultException) {
              UtilFs.showErrorToast(
                  resultException.graphqlErrors[0].message, context);
              print(resultException.graphqlErrors[0].message);
            },
            onCompleted: (dynamic resultData) {
              if (resultData != null) {
                if (resultData['signinUser']['token'] != null) {
                  UtilFs.showSuccessToast("Login Successfully.", context);
                  Storage().setToken(resultData['signinUser']['token']);
                  Get.to(MainPage());
                }
              }
            },
          ),
          builder: (runMutation, result) {
            return Scaffold(
              body: Container(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      child: CachedNetworkImage(
                        imageUrl:
                            "http://spic.iranshao.com/attachment_fields_cy7p4w7kyta_0000000-1.png",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: accountController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Account',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        margin: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          child: const Text('Login'),
                          onPressed: () {
                            runMutation({
                              'email': accountController.text,
                              'password': passwordController.text,
                            });
                          },
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: <Widget>[
                        const Text('Does not have account?'),
                        TextButton(
                          child: const Text(
                            'Register One',
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            Get.toNamed('/signup');
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
