import 'package:flutter/material.dart';
import 'package:surveyapp/login_screen.dart';
import 'package:surveyapp/database.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = "/profile";

  ProfilePage({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    String name = "Alan";
    String email = username;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
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
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 4.0),
      child: Text(
        headerText,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        child: Text("Logout"),
      ),
    );
  }

  Widget _buildDeleteAccountButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
      child: ElevatedButton(
        onPressed: () {
          Database.deleteUser(username);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        child: Text("Delete Account"),
      ),
    );
  }

  Widget _buildHelpButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
      child: ElevatedButton(
        onPressed: () {
          // https://cdn.discordapp.com/attachments/1119084344192016384/1128786582615359590/image.png
        },
        child: Text("Help"),
      ),
    );
  }
}
