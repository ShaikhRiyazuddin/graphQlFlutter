import 'package:flutter/material.dart';
import 'package:graph_ql_app/querys.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  final String employeeId;

  EmployeeDetailsScreen({required this.employeeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(GraphQLQueries.getEmployeeDetails(employeeId)),
        ),
        builder: (QueryResult result, {refetch, fetchMore}) {
          if (result.hasException) {
            return Center(
              child: Text(result.exception.toString()),
            );
          }

          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final employee = result.data?['employee'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${employee['name']}'),
                Text('Department: ${employee['department']}'),
                Text('Email: ${employee['email']}'),
                Text('Phone: ${employee['phone']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
