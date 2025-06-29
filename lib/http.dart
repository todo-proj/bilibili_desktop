import 'package:http/http.dart' as http;

void test() async {
  var url = Uri.https('pub.dev','/packages/http');
  var response = await http.get(url);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  print(await http.read(Uri.https('example.com', 'foobar.txt')));
}