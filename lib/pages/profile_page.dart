import 'package:adhicine/pages/auth_gate.dart';
import 'package:adhicine/state/auth_provider.dart';
import 'package:adhicine/widgets/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePageM extends StatefulWidget {
  const ProfilePageM({super.key});

  @override
  State<ProfilePageM> createState() => _ProfilePageMState();
}

class _ProfilePageMState extends State<ProfilePageM> {
  void _signOut(BuildContext context) async {
    try {
      await Provider.of<AuthProvider>(context, listen: false).signOut();
      Navigator.pushAndRemoveUntil(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const AuthGate()),
        (route) => false,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sign out failed: ${e.toString()}")),
      );
    }
  }

  int selectedTile = 0;

  final String userName = 'Harry';
  final String profileImageUrl = 'assets/images/profile_image.jpeg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 200, 223, 234),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
                const SizedBox(height: 25),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Column(
                      children: [
                        Hero(
                          tag: 'hero',
                          child: CircleAvatar(
                            radius: 55,
                            backgroundImage: AssetImage(profileImageUrl),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          userName,
                          style: GoogleFonts.lexend(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ProfileTile(
                          text: 'log Out',
                          icon: Icons.logout,
                          isSelected: selectedTile == 4,
                          onTap: () {
                            setState(() {
                              selectedTile = 4;
                            });
                            _signOut(context);
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
