import 'package:flutter/material.dart';

import 'package:hyperlink/hyperlink.dart';

import 'package:home_page/styles.dart';

class ContactWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 20, top: 20),
      children: [
        HyperLink(
          linkStyle: linkStyle,
          text:
              "Feel free to send me an email at [jzs1986@gmail.com](mailto:jzs1986@gmail.com)",
        ),
      ],
    );
  }
}
