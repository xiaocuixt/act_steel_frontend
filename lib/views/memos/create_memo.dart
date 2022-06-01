import 'package:act_steel_frontend/components/utils.dart';
import 'package:act_steel_frontend/controllers/memos_controller.dart';
import 'package:act_steel_frontend/services/graphql_conf.dart';
import 'package:act_steel_frontend/graphql/gpl_memos.dart';
import 'package:act_steel_frontend/models/memo.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:act_steel_frontend/services/login_info.dart';

class CreateMemo extends StatefulWidget {
  const CreateMemo({Key? key}) : super(key: key);

  @override
  _CreateMemoState createState() => _CreateMemoState();
}

class _CreateMemoState extends State<CreateMemo> {
  TextEditingController contentController = TextEditingController();
  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginInfo = LoginInfo();
    return GraphQLProvider(
      client: GraphqlConf.initGraphqlClient(loginInfo.token),
      child: Container(
        height: 150,
        child: Mutation(
          options: MutationOptions(
            document: gql(GqlMemos.createMemo),
            onError: (dynamic resultException) {
              UtilFs.showErrorToast(
                  resultException.graphqlErrors[0].message, context);
              print(resultException.graphqlErrors[0].message);
            },
            onCompleted: (dynamic resultData) {
              if (resultData != null) {
                if (resultData['createMemo']['memo']['id'] != null) {
                  UtilFs.showSuccessToast(
                      "Memo created Successfully.", context);
                  Get.find<MemosController>()
                      .addMemo(Memo.fromJson(resultData['createMemo']['memo']));
                }
              }
            },
          ),
          builder: (runMutation, result) {
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: ListView(
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                        controller: contentController,
                        keyboardType: TextInputType.multiline,
                        minLines: 3,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Memo Content...',
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            child: const Text('Submit'),
                            onPressed: () {
                              runMutation({
                                'memoableId': '1',
                                'memoableType': "User",
                                'content': contentController.text,
                              });
                              contentController.clear();
                              Navigator.of(context).pop();
                            },
                          ),
                        )),
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
