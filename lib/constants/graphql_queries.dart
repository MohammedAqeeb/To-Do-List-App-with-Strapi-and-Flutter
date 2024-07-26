import 'package:graphql_flutter/graphql_flutter.dart';

HttpLink httpLink = HttpLink('http://192.168.14.21:1337/graphql');

GraphQLClient graphQLClient = GraphQLClient(
  link: httpLink,
  cache: GraphQLCache(
    store: HiveStore(),
  ),
);

const String getFetchQuery = """
query {
  taskManagers {
    data {
      id
      attributes {
        Title
        Description
        Completed
      }
    }
  }
}
""";

const String taskUpdateQuery = '''
      mutation UpdateTaskCompletion(\$id: ID!, \$completed: Boolean!) {
        updateTaskManager(id: \$id, data: { Completed: \$completed }) {
          data {
            id
            attributes {
              Title
              Description
              Completed
            }
          }
        }
      }
    ''';

const String addNewTask = '''

 mutation CreateTask(\$title: String!, \$description: String!, \$completed: Boolean!) {
  createTaskManager(data: { Title: \$title, Description: \$description, Completed: \$completed }) {
    data {
      id
      attributes {
        Title
        Description
        Completed
      }
    }
  }
}



''';
