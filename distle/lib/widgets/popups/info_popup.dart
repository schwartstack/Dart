import 'package:flutter/material.dart';

import 'package:hyperlink/hyperlink.dart';

import 'package:distle/config/constants.dart';

class InfoPopup extends StatelessWidget {
  final TextStyle linkStyle = TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );
  InfoPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Row(
        children: [
          const Expanded(child: Text("Contact")),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          HyperLink(
            linkStyle: linkStyle,
            text:
                "To report a bug or for any other reason: [email me](mailto:jzs1986@gmail.com)",
          ),
          SizedBox(height: 5),
          HyperLink(
            linkStyle: linkStyle,
            text:
                "Check out my [website](http://schwartstack.github.io), my [LinkedIn](http://www.linkedin.com/in/schwartstack), and my [GitHub](https://github.com/schwartstack/)",
          ),
          SizedBox(height: 5),
          HyperLink(
            linkStyle: linkStyle,
            text:
                "If you enjoy this game and you want to support it, you can [buy me a coffee](https://ko-fi.com/schwartstack)",
          ),
          SizedBox(height: 20),
          Center(
            child: SelectableText(
              style: TextStyle(color: Colors.grey, fontSize: 10),
              "version $version",
            ),
          ),
        ],
      ),
    );
  }
}
