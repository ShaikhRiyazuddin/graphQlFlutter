import 'package:flutter/material.dart';
import 'package:graph_ql_app/employee_details_screen.dart';
import 'package:graph_ql_app/querys.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EmployeeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Directory'),
      ),
      body: Query(
        options: QueryOptions(
          document: gql('''query {
              employees {
                id
                name
                department
                email
                phone
              }
            }'''),
        ),
        builder: (QueryResult result, {refetch, fetchMore }) {
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

          List employees = result.data?['employees'];

          return ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final employee = employees[index];
              return ListTile(
                title: Text(employee['name']),
                subtitle: Text('${employee['department']} - ${employee['phone']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployeeDetailsScreen(employeeId: employee['id']),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
