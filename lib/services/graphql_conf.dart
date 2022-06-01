import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:act_steel_frontend/services/storage.dart';

class GraphqlConf {
  //static String backendUrl = "http://20.205.132.174:3000/graphql";
  static String backendUrl = "http://localhost:9200/graphql";
  static String _token = Storage().token;

  static final HttpLink httpLink = HttpLink(
    backendUrl,
  );

  static final AuthLink authLink = AuthLink(
    getToken: () async => _token,
  );

  static final Link link = authLink.concat(httpLink);

  static ValueNotifier<GraphQLClient> initGraphqlClient(token) {
    _token = token;
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(store: InMemoryStore()),
        link: link,
      ),
    );
    return client;
  }
}
