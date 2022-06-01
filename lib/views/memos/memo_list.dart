import 'package:act_steel_frontend/controllers/memos_controller.dart';
import 'package:act_steel_frontend/graphql/gpl_memos.dart';
import 'package:act_steel_frontend/models/memo.dart';
import 'package:act_steel_frontend/services/graphql_conf.dart';
import 'package:act_steel_frontend/services/login_info.dart';
import 'package:act_steel_frontend/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MemoList extends StatefulWidget {
  const MemoList({Key? key}) : super(key: key);

  @override
  _MemoListState createState() => _MemoListState();
}

class _MemoListState extends State<MemoList> {
  String fetchMoreCursor = "";
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final loginInfo = LoginInfo();
    List memos = [];

    return GraphQLProvider(
        client: GraphqlConf.initGraphqlClient(loginInfo.token),
        child: Query(
          options: QueryOptions(
            document: gql(GqlMemos.connectionMemo),
            variables: {'first': 15},
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
              return const Text('No Memos.');
            }

            var data = result.data ?? {};

            // print("xxxxxxxxxx");
            // print(data['memosConnection']['edges']);


            memos = data['memosConnection']['edges']
                .map((e) => Memo.fromJson(e['node']))
                .toList();

            // this is returned by the GitHubs GraphQL API for pagination purpose
            Map pageInfo = data['memosConnection']['pageInfo'];
            String fetchMoreCursor = pageInfo['endCursor'];
            bool hasNextPage = pageInfo['hasNextPage'];

            FetchMoreOptions opts = FetchMoreOptions(
              variables: {'after': fetchMoreCursor},
              updateQuery: (previousResultData, fetchMoreResultData) {
                // this function will be called so as to combine both the original and fetchMore results
                // it allows you to combine them as you would like
                final List<dynamic> repos = [
                  ...previousResultData?['memosConnection']['edges']
                      as List<dynamic>,
                  ...fetchMoreResultData?['memosConnection']['edges']
                      as List<dynamic>
                ];

                fetchMoreResultData?['memosConnection']['edges'] = repos;
                return fetchMoreResultData;
              },
            );

            return Column(
              children: [
                NotificationListener(
                    child: GetBuilder<MemosController>(
                      init: MemosController(),
                      builder: (_) {
                        if (_.memos.length > 0) {
                          var lastMemo = _.memos.last;
                          memos = [lastMemo, ...memos].toSet().toList();
                        }
                        return Expanded(
                            child: ListView.builder(
                                key: PageStorageKey("listMemos"),
                                shrinkWrap: true,
                                controller: _controller,
                                padding: EdgeInsets.all(8),
                                itemCount: memos.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Text(memos[index].content),
                                    subtitle: Text(memos[index].createdAt),
                                  );
                                }));
                      },
                    ),
                    onNotification: (dynamic t) {
                      if (t is ScrollEndNotification &&
                          _controller.position.pixels >=
                              _controller.position.maxScrollExtent &&
                          hasNextPage &&
                          result.isNotLoading) {
                        fetchMore!(opts);
                      }
                      return true;
                    })
              ],
            );
          },
        ));
  }
}
