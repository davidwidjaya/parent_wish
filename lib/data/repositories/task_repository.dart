import 'package:parent_wish/data/responses/auth_response.dart';
import '../../utils/api_client.dart';

class TaskRepository {
  Future<AddTaskResponse> addTask({
    required String name,
    required String description,
    required String age,
    required String frequently,
    required String videoURL,
  }) async {
    final response = await ApiClient.post(
      '/task/add',
      body: {
        'task_name': name,
        'task_desc': description,
        'age_category': age,
        'task_category': 'dummy',
        'task_frequntly': frequently,
        'task_vidio_url': videoURL
      },
    );

    print(response);
    if (response['status_code'] == 201) {
      return AddTaskResponse.fromJson(response);
    } else {
      throw Exception('Failed to add task: ${response['body']}');
    }
  }
}
