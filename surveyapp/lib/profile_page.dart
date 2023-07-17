import 'package:flutter/material.dart';
import 'package:surveyapp/login_screen.dart';
import 'package:surveyapp/database.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "/profile";

  const ProfilePage({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "Alan";
  String email = "";

  String selectedOption = "Help";

  @override
  void initState() {
    super.initState();
    email = widget.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, right: 16.0),
        children: [
          _buildSection("Name"),
          _buildText(name),
          _buildSection("Email"),
          _buildText(email),
          _buildSection("Logout"),
          _buildLogoutButton(context),
          _buildSection("Delete Account"),
          _buildDeleteAccountButton(context),
          _buildSection("Help"),
          _buildHelpButton(),
        ],
      ),
    );
  }

  Widget _buildSection(String headerText) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 4.0, right: 16.0),
      child: Text(
        headerText,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, right: 16.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, right: 16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        child: const Text("Logout"),
      ),
    );
  }

  Widget _buildDeleteAccountButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, right: 16.0),
      child: ElevatedButton(
        onPressed: () {
          Database.deleteUser(widget.username);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        child: const Text("Delete Account"),
      ),
    );
  }

  Widget _buildHelpButton() {
    Map<String, String> helpTexts = Map<String, String>();
    helpTexts["Help"] = "Select a help option";
    
    helpTexts["FAQ"] = "FAQ"; // TODO: Add FAQ

    helpTexts["Getting Started"] = "Getting Started";

    helpTexts["Privacy and Security"] = 
"""
At [App Name], we prioritize the privacy and security of our users' information. This section outlines how we protect your data and explains how we collect, use, and share information within our app. By using [App Name], you agree to the practices described in this section.

Data Collection and Usage:
We collect information necessary to provide you with a personalized app experience. This includes personal information like your name, email address, and profile picture when you create an account or use specific features. We also gather anonymous usage data, such as your interactions within the app, device information, and technical logs, to improve our services.

Data Storage and Security:
We take measures to safeguard your data from unauthorized access, loss, or alteration. We use industry-standard encryption techniques to protect your data during transmission and storage. Access to your data is limited to authorized personnel, who are required to maintain its confidentiality. We retain your data for as long as necessary and securely erase it when you delete your account.

Data Sharing:
We do not sell your personal information to third parties. However, we may share data with trusted third-party service providers who assist us in delivering our app's functionalities. We may also disclose your information if required by law or to protect our rights or the rights of others.

User Controls and Choices:
You have control over your data. Within the app, you can review and update your account information, adjust privacy preferences, and opt-out of certain data collection or marketing communications. You can also request access to your personal data or its deletion by contacting our support team.

Children's Privacy:
Our app is not intended for children under 13 years old, and we do not knowingly collect personal information from children. If you believe we have inadvertently collected information from a child, please contact us, and we will promptly delete it.

Updates to Privacy and Security Policy:
We may update this privacy and security section periodically to reflect changes in our practices or legal requirements. It's advisable to review this section regularly to stay informed about how we protect your information.

If you have any questions or concerns about our privacy and security practices, please contact us at [contact information].
"""; 


    String helpText = helpTexts[selectedOption]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, right: 16.0),
          child: DropdownButton<String>(
            value: selectedOption,
            items: const [
              DropdownMenuItem(
                value: "Help", 
                child: Text("Help")
              ),
              DropdownMenuItem(
                value: 'FAQ',
                child: Text('FAQ'),
              ),
              DropdownMenuItem(
                value: 'Getting Started',
                child: Text('Getting Started'),
              ),
              DropdownMenuItem(
                value: 'Privacy and Security',
                child: Text('Privacy and Security'),
              ),
            ],
            onChanged: (String? newValue) {
              setState(() {
                selectedOption = newValue!;
              });
            },
          )
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
          child: Text(
            helpText,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        )
      ],
    );
  }
}
