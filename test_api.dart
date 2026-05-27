import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  try {
    final body3 = {
      'user': 'CNH7UgYOknPXJaZDZ5aw9Z56l5j2',
      'conditionName': 'anxiety'
    };
    final res3 = await http.post(
      Uri.parse('http://192.168.1.200:8080/api/v1/mental-conditions'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body3)
    );
    print('POST user as string: ${res3.statusCode}');
    print(res3.body);

    final body4 = {
      'user': {'user_id': 'CNH7UgYOknPXJaZDZ5aw9Z56l5j2'},
      'conditionName': 'anxiety'
    };
    final res4 = await http.post(
      Uri.parse('http://192.168.1.200:8080/api/v1/mental-conditions'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body4)
    );
    print('POST user nested user_id: ${res4.statusCode}');
    print(res4.body);
  } catch (e) {
    print(e);
  }
}
