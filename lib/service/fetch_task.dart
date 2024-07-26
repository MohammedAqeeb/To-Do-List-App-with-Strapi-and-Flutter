import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:strapitodapp/model/task.dart';

import '../constants/graphql_queries.dart' as query_string;

class FetchTaskData {
  /// Function to get All task Using graphql query
  ///
  Future<List<TaskManager>> getTask() async {
    QueryResult queryResult = await query_string.graphQLClient.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        // graphql query
        document: gql(query_string.getFetchQuery),
      ),
    );

    if (queryResult.hasException) {
      print('error: ${queryResult.exception.toString()}');
      return [];
    }

    final List data = queryResult.data?['taskManagers']?['data'] ?? [];

    print(' data: $data');

    final taskManagers = data
        .map<TaskManager>(
            (json) => TaskManager.fromJson(json as Map<String, dynamic>))
        .toList();

    return taskManagers;
  }

  /// Function to update task completion Using graphql query
  ///
  /// * [taskId] to update particular task
  /// * [isCompleted] to update task status
  ///
  Future updateTaskCompletion(int taskId, bool isCompleted) async {
    final GraphQLClient graphQLClient = GraphQLClient(
      link: query_string.httpLink,
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    );

    final MutationOptions options = MutationOptions(
      document: gql(query_string.taskUpdateQuery),
      variables: {
        'id': taskId,
        'completed': isCompleted,
      },
    );

    final QueryResult queryResult = await graphQLClient.mutate(options);
    if (queryResult.hasException) {
      // Handle GraphQL exceptions
      print('GraphQL Exception: ${queryResult.exception.toString()}');
    } else {
      print('Task completion updated successfully');
    }
  }

  /// Function to add task completion Using graphql query
  ///
  /// * [title] to add task title
  /// * [desc] to add task desc
  /// * [completed] completed is set to be false be default
  ///

  Future addTask(String title, String desc) async {
    final GraphQLClient graphQLClient = GraphQLClient(
      link: query_string.httpLink,
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    );

    final MutationOptions options = MutationOptions(
      document: gql(query_string.addNewTask),
      variables: {
        'title': title,
        'description': desc,
        'completed': false,
      },
    );

    await graphQLClient.mutate(options);
  }
}
