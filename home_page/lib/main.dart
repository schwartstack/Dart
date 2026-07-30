import "package:flutter/material.dart";

import "package:url_launcher/url_launcher.dart";

import "package:home_page/widgets/bio_widget.dart";
import "package:home_page/widgets/contact_widget.dart";
import "package:home_page/widgets/projects_widget.dart";
import "package:home_page/widgets/publications_widget.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final colorScheme = ColorScheme.fromSeed(seedColor: Colors.orange);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Jonathan Schwartz's Web Page",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        // scaffoldBackgroundColor: colorScheme.surface,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTab = 0;

  final List<String> tabNames = const [
    "Projects",
    "Publications",
    "Bio",
    "Contact",
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top tabs
            Container(
              color: colors.surfaceContainerLow,
              child: Row(
                children: List.generate(tabNames.length, (index) {
                  final selected = index == selectedTab;

                  return Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedTab = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: selected
                              ? colors.surface
                              : colors.surfaceContainerHighest,
                          border: Border.all(color: colors.outlineVariant),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            tabNames[index],
                            style: TextStyle(
                              fontWeight: selected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Main content
            Expanded(
              child: IndexedStack(
                index: selectedTab,
                children: [
                  ProjectsWidget(),
                  PublicationsWidget(),
                  BioWidget(),
                  ContactWidget(),
                ],
              ),
            ),

            // Bottom button bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: colors.surfaceContainerLow,
                border: Border(top: BorderSide(color: colors.outlineVariant)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton.icon(
                    onPressed: () {
                      launchUrl(
                        Uri.parse(
                          "https://schwartstack.github.io/docs/Jonathan-Schwartz-Resume.pdf",
                        ),
                      );
                    },
                    icon: const Icon(Icons.download),
                    label: const Text("Resume"),
                  ),

                  FilledButton.icon(
                    onPressed: () {
                      launchUrl(
                        Uri.parse("http://www.linkedin.com/in/schwartstack"),
                      );
                    },
                    icon: const Icon(Icons.link),
                    label: const Text("LinkedIn"),
                  ),

                  FilledButton.icon(
                    onPressed: () {
                      launchUrl(Uri.parse("http://github.com/schwartstack"));
                    },
                    icon: const Icon(Icons.link),
                    label: const Text("GitHub"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageWidget extends StatelessWidget {
  final String title;

  const PageWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title, style: Theme.of(context).textTheme.headlineMedium),
    );
  }
}
