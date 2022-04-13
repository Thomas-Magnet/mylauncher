import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

void main() {
  runApp(const Launcher());
}

class Launcher extends StatelessWidget {
  const Launcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 32, 32),
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          const Center(
            child: Text(
              "My Launcher",
              style: TextStyle(color: Colors.white70),
            ),
          ),
          FutureBuilder(
            future: DeviceApps.getInstalledApplications(
              includeSystemApps: true,
              includeAppIcons: true,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<Application> allApps = snapshot;
                return ListView(
                  children: List.generate(
                    allApps.length,
                    // 1,
                    (index) {
                      return Column(
                        children: [
                          const CircleAvatar(),
                          Text(
                            "${snapshot.appName}",
                            style: const TextStyle(color: Colors.amber),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )
        ],
      ),
    );
  }
}
