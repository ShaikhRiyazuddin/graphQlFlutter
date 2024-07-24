import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graph_ql_app/employee_list_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(MyApp());
}

String get host {
  if (Platform.isAndroid) {
    return '10.0.2.2';
  } else {
    return 'localhost';
 }
}

final graphqlEndpoint = 'http://$host:3000/graphql';
final subscriptionEndpoint = 'ws://$host:3000/subscriptions';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
     graphqlEndpoint
     //'YOUR_GRAPHQL_ENDPOINT',
    );

    final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Employee Directory',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: EmployeeListScreen(),
      ),
    );
  }
}
