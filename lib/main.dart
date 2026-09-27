import 'package:flutter/material.dart';

void main() {
  runApp(const MiCardApp());
}

class MiCardApp extends StatelessWidget {
  const MiCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MiCard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const MiCardPage(),
    );
  }
}

class MiCardPage extends StatelessWidget {
  const MiCardPage({super.key});

  static const _primaryColor = Color(0xFF00796B);
  static const _backgroundColor = Color(0xFF00897B);
  static const _accentColor = Color(0xFFB2DFDB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ProfileAvatar(),
                  SizedBox(height: 16),
                  Text(
                    'Trần Hoàng Nhật',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'SOFTWARE ENGINEER',
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      color: _accentColor,
                      fontSize: 20,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 24,
                    width: 160,
                    child: Divider(color: _accentColor, thickness: 1),
                  ),
                  _ContactCard(
                    icon: Icons.phone,
                    label: 'Số điện thoại',
                    value: '0987079483',
                  ),
                  SizedBox(height: 12),
                  _ContactCard(
                    icon: Icons.email,
                    label: 'Email',
                    value: 'thndev05@gmail.com',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Ảnh đại diện Trần Hoàng Nhật',
      image: true,
      child: const CircleAvatar(
        radius: 60,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage('images/profile.jpg'),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label: $value',
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 2,
        child: ListTile(
          leading: Icon(icon, color: MiCardPage._primaryColor),
          title: Text(
            value,
            style: const TextStyle(
              color: Color(0xFF004D40),
              fontFamily: 'Source Sans Pro',
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
