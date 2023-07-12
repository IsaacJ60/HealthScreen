import 'package:http/http.dart' as http;

Future<bool> sendEmailInBackground(String email, String password) async {
  const apiEndpoint = 'https://api.elasticemail.com/v2/email/send';
  const apiKey =
      'E33863C420E792AD6F31D70A9865CC50F995F26E40F7514F28578DD747249CC54B5CC597F1B63AA4D04E54DE95387399'; // we should probably hide this

  final requestHeaders = {
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  final requestBody = {
    'apikey': apiKey,
    'from': 'jacob.gaisinsky@gmail.com', // TODO: Replace with sender email
    'subject': 'Health Screening Password Recovery',
    'to': email,
    'bodyHtml': 'Your password is $password.',
  };

  final response = await http.post(
    Uri.parse(apiEndpoint),
    headers: requestHeaders,
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Email sent successfully
    print('Email sent to $email');
    return true;
  } else {
    // Error occurred while sending email
    print('Failed to send email: ${response.body}');
    return false;
  }
}
