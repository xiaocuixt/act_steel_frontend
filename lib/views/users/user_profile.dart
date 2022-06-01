import 'package:act_steel_frontend/controllers/avatar_controller.dart';
import 'package:act_steel_frontend/helpers/image_helper.dart';
import 'package:act_steel_frontend/views/users/user_avatar.dart';
import 'package:act_steel_frontend/widgets/app_text.dart';
import 'package:act_steel_frontend/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:act_steel_frontend/graphql/gql_users.dart';
import 'package:act_steel_frontend/services/graphql_conf.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:act_steel_frontend/services/login_info.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  static const BottomNavigationBarItem navItem = BottomNavigationBarItem(
    icon: Icon(Icons.supervised_user_circle_sharp),
    label: 'User',
  );

  @override
  UserProfileState createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  String avatar = '';
  @override
  Widget build(BuildContext context) {
    final loginInfo = LoginInfo();

    return GraphQLProvider(
        client: GraphqlConf.initGraphqlClient(loginInfo.token),
        child: Query(
          options: QueryOptions(
            document: gql(GqlUsers.fetchMe),
            variables: {},
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading) {
              return Loading();
            }

            if (result.data == null) {
              return const Text('Not Login.');
            }

            var data = result.data ?? {};

            avatar = data['me']['avatarUrl'];

            return Padding(
                padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                child: Row(children: [
                  Column(
                    children: [
                      GetBuilder<AvatarController>(builder: (_) {
                        avatar = (_.avatar != null && _.avatar != "")
                            ? _.avatar
                            : avatar;
                        return Container(
                          child: cachedImage(avatar, width: 100, height: 100),
                        );
                      }),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 30,
                        width: 160,
                        child: UserAvatar(),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      AppText(text: data['me']['email']),
                    ],
                  )
                ]));
          },
        ));
  }
}
