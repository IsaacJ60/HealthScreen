import 'package:flutter/material.dart';
import 'package:surveyapp/login_screen.dart';
import 'package:surveyapp/database.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "/profile";

  const ProfilePage({Key? key, required this.username, required this.name})
      : super(key: key);

  final String username;
  final String name;

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
    name = widget.name;
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
      padding: const EdgeInsets.only(
          left: 16.0, top: 16.0, bottom: 4.0, right: 16.0),
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
    String faqText1 =
        "Q: How do I change the password in my HealthScreen account? \n A:To change the password to a registered account, follow the steps: \n 1. Open Health Screen -> Go to Profile Page by clicking account icon at top left on the dashboard page -> press logout \n Sign back into Health Screen and press forget password to reset your password";

    helpTexts["Help"] = "Select a help option";
    helpTexts["FAQ"] = faqText1; // TODO: Add FAQ
    helpTexts["Getting Started"] =
        "Getting Started"; // TODO: Add Getting Started
    helpTexts["Privacy and Security"] =
        "Privacy and Security"; // TODO: Add Privacy and Security

    String helpText = helpTexts[selectedOption]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding:
                const EdgeInsets.only(left: 16.0, bottom: 16.0, right: 16.0),
            child: DropdownButton<String>(
              value: selectedOption,
              items: const [
                DropdownMenuItem(value: "Help", child: Text("Help")),
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
            )),
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
