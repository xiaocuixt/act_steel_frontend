import 'package:act_steel_frontend/controllers/avatar_controller.dart';
import 'package:act_steel_frontend/services/graphql_conf.dart';
import 'package:flutter/material.dart';
import 'package:act_steel_frontend/graphql/gql_users.dart';
import 'package:act_steel_frontend/components/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:act_steel_frontend/services/login_info.dart';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class UserAvatar extends StatefulWidget {
  const UserAvatar({Key? key}) : super(key: key);
  @override
  UserAvatarState createState() => UserAvatarState();
}

class UserAvatarState extends State<UserAvatar> {
  late List<int> _selectedFile;

  excuteMutation() {
    return Mutation(
      builder: (runMutation, result) {
        return Container(
          width: 60,
          height: 30,
          child: ElevatedButton.icon(
            label: const Text('Upload Avatar'),
            icon: Icon(Icons.cloud_upload),
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles(
                allowMultiple: false,
                type: FileType.image,
              );
              if (result == null) return;
              final file = result.files.single;
              // print(file);
              // print('Size: ${file.readStream}');
              print('name: ${file.name}');
              // print('Size: ${file.size}');
              // print('bytes: ${file.bytes}');
              print('Extension: ${file.extension}');
              // print('Path: ${file.path}');
              _selectedFile = file.bytes ?? Uint8List(0);

              // print(_selectedFile);
              final myFile = http.MultipartFile.fromBytes(
                "avatar",
                _selectedFile,
                filename: file.name,
                contentType: new MediaType('image', 'jpeg'),
              );

              runMutation({
                'avatar': myFile,
              });
            },
          ),
        );
      },
      options: MutationOptions(
        document: gql(GqlUsers.updateAvatar),
        onCompleted: (dynamic resultData) {
          // print(resultData);
          if (resultData != null) {
            // print(resultData);

            if (resultData['updateAvatar']['user']['avatarUrl'] != null) {
              Get.find<AvatarController>()
                  .setAvatar(resultData['updateAvatar']['user']['avatarUrl']);
              UtilFs.showSuccessToast("Upload Successful", context);
            }
          } else {
            UtilFs.showErrorToast("Upload Failed", context);
          }
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    final loginInfo = LoginInfo();

    return GraphQLProvider(
      client: GraphqlConf.initGraphqlClient(loginInfo.token),
      child: excuteMutation(),
    );
  }
}
