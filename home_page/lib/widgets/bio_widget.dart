import 'package:flutter/material.dart';

import 'package:hyperlink/hyperlink.dart';

import 'package:home_page/styles.dart';

class BioWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 20, top: 20),
      children: [
        SelectableText(
          "Hello. My name is Jonathan Schwartz. I grew up in San Jose, California. I have a Master's degree in statistics from San Jose State University and a Bachelor's degree in music from Humboldt State University.\n\nSince 2023 I've worked for the American Thrombosis and Hemostatis Network as a data scientist. From 2021 to 2023 I worked as a Machine Learning Software Engineer for PerformaceStar LLC. Before that, I was working as an R, probability, and statistics tutor and getting my Masters in Satatistics at San Jose State University.",
        ),
        SizedBox(height: 20),
        SelectableText(
          "In my time as an online tutor at Wyzant, I'm very proud of the amount of 5 star reviews I received.",
        ),
        HyperLink(
          linkStyle: linkStyle,
          text:
              "    Check out [what my students had to say about me on Wyzant](https://www.wyzant.com/Tutors/CA/Campbell/9784954#reviews)",
        ),
        SizedBox(height: 20),
        SelectableText(
          "I'm also a volunteer with Statistics Without Borders. One of the projects I helped with was a series of videos about statistics volunteers produced for The African Institute for Professional Development.",
        ),
        HyperLink(
          linkStyle: linkStyle,
          text:
              "    Check out my [video about R vectors on Youtube](https://www.youtube.com/watch?v=DH4EU3smLwk)",
        ),
        SizedBox(height: 20),
        SelectableText(
          "I've contributed to The On-Line Encyclopedia of Integer Sequences.",
        ),
        HyperLink(
          linkStyle: linkStyle,
          text:
              "    Check out my [contributions to the OEIS](https://oeis.org/search?go=Search&language=english&q=%22jonathan%20schwartz%22)",
        ),
        SizedBox(height: 20),
        SelectableText(
          "Many years ago, I wrote guides on how to solve a Rubik's Cube.",
        ),
        HyperLink(
          linkStyle: linkStyle,
          text:
              "    Check out my [beginner's guide](https://schwartstack.github.io/docs/RubiksCube.pdf) and my [advanced guide](https://schwartstack.github.io/docs/OLLandPLL.pdf)",
        ),
        SizedBox(height: 20),
        SelectableText("In my free time I love to play board and card games."),
        HyperLink(
          linkStyle: linkStyle,
          text:
              "    Check out my [collection on BoardGameGeek](https://boardgamegeek.com/collection/user/schwartstack)",
        ),
        SizedBox(height: 20),
        SelectableText("I play guitar and write music. Or at least I used to."),
        HyperLink(
          linkStyle: linkStyle,
          text:
              "    Check out my [some of my older music on SoundCloud](https://soundcloud.com/schwartstack/sets/music-by-schwartstack)",
        ),
        SizedBox(height: 20),
        SelectableText(
          "I wanted to be a cartoonist when I was a kid. I loved The Far Side and Calvin and Hobbes",
        ),
        HyperLink(
          linkStyle: linkStyle,
          text:
              "    Check out my [old cartoons on Tumblr](https://placematpangea.tumblr.com/)",
        ),
      ],
    );
  }
}
