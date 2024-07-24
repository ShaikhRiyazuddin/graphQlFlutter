class GraphQLQueries {
  static const String getEmployees = '''
    query {
      employees {
        id
        name
        department
        email
        phone
      }
    }
  ''';

  static String getEmployeeDetails(String id) {
    return '''
      query {
        employee(id: "$id") {
          id
          name
          department
          email
          phone
        }
      }
    ''';
  }
}
