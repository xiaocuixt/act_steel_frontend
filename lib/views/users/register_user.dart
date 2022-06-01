import 'package:flutter/material.dart';
import 'package:act_steel_frontend/graphql/gql_users.dart';
import 'package:act_steel_frontend/services/graphql_conf.dart';
import 'package:act_steel_frontend/components/utils.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:act_steel_frontend/services/storage.dart';
import 'package:act_steel_frontend/services/login_info.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  @override
  Widget build(BuildContext context) {
    TextEditingController accountController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController passwordConfirmationController =
        TextEditingController();

    String _password = '';
    String _confirmPassword = '';

    final loginInfo = LoginInfo();
    return GraphQLProvider(
      client: GraphqlConf.initGraphqlClient(loginInfo.token),
      child: Scaffold(
        body: Mutation(
          options: MutationOptions(
            document: gql(GqlUsers.signupUser),
            onError: (dynamic resultException) {
              UtilFs.showErrorToast(
                  resultException.graphqlErrors[0].message, context);
              print(resultException.graphqlErrors[0].message);
            },
            onCompleted: (dynamic resultData) {
              if (resultData != null) {
                if (resultData['signupUser']['token'] != null) {
                  UtilFs.showSuccessToast("Signup Successfully.", context);
                  Storage().setToken(resultData['signupUser']['token']);
                  Get.toNamed('/profile');
                }
              }
            },
          ),
          builder: (runMutation, result) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 140,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: accountController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Email/Mobile',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'password is required';
                          }
                          if (val.trim().length < 8) {
                            return 'password must more than 8 characters';
                          }
                        },
                        onChanged: (value) => _password = value,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordConfirmationController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password Confirmation',
                        ),
                        validator: (value) {
                          if (value != _password) {
                            return 'Confimation password does not match the entered password';
                          }
                        },
                        onChanged: (value) => _confirmPassword = value,
                      ),
                    ),

                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        margin: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          child: const Text('Sign Up'),
                          onPressed: () {
                            runMutation({
                              'email': accountController.text,
                              'password': passwordController.text,
                              'passwordConfirmation':
                                  passwordConfirmationController.text,
                            });
                          },
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: <Widget>[
                        const Text('Already Register?'),
                        TextButton(
                          child: const Text(
                            'Sign in',
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            Get.toNamed('/signin');
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    // Row(
                    //   children: <Widget>[
                    //     const Text('Does not have account?'),
                    //     TextButton(
                    //       child: const Text(
                    //         'Sign in',
                    //         style: TextStyle(fontSize: 20),
                    //       ),
                    //       onPressed: () {
                    //         //signup screen
                    //       },
                    //     )
                    //   ],
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    // ),
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
