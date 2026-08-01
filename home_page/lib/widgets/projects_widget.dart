import 'package:flutter/material.dart';

import 'package:hyperlink/hyperlink.dart';

import 'package:home_page/styles.dart';

class ProjectsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 20, top: 20),
      children: [
        CollapsibleSection(
          title: "Shiny Apps",
          children: [
            HyperLink(
              linkStyle: linkStyle,
              text:
                  "• [Home Run Probability Simulator](https://schwartstack.github.io/home_run): Given an MLB stadium and a hit's speed and angle, this app written in R Shiny visualizes the hit's probability of resulting in a home run. (Give it a minute to load.)",
            ),
          ],
        ),
        CollapsibleSection(
          title: "Flutter Apps",
          children: [
            HyperLink(
              linkStyle: linkStyle,
              text:
                  "• [Distle](https://distle.xyz): A Wordle-inspired daily word puzzle game.",
            ),
            HyperLink(
              linkStyle: linkStyle,
              text:
                  "• [Band Namer](https://schwartstack.github.io/band_namer): A random band name generator written in Dart/Flutter.",
            ),
          ],
        ),
        CollapsibleSection(
          title: "R Projects",
          children: [
            HyperLink(
              linkStyle: linkStyle,
              text:
                  "• [handyplots](https://github.com/schwartstack/handyplots): An R package with several handy functions for quickly visualizing numeric data. This package was written in grad school for an R class, but I later officially published it to [CRAN](https://cran.r-project.org/web/packages/handyplots/index.html), so any R user in the world can install and use it.",
            ),
            HyperLink(
              linkStyle: linkStyle,
              text:
                  "• [15-Puzzle](https://github.com/schwartstack/15puzzle): A playable sliding-style puzzle written entirely in R.",
            ),
            HyperLink(
              linkStyle: linkStyle,
              text:
                  "• [Dicify](https://github.com/schwartstack/dicify): Transforms an image into a mosaic made of dice.",
            ),
            HyperLink(
              linkStyle: linkStyle,
              text:
                  "• [Say Number](https://github.com/schwartstack/say_number): A function which converts a number to its english language represenatation.",
            ),
            HyperLink(
              linkStyle: linkStyle,
              text:
                  "• [Sudoku Solver](https://github.com/schwartstack/sudoku): A function that algorithmically solves sudoku puzzles.",
            ),
            HyperLink(
              linkStyle: linkStyle,
              text:
                  "• [Webscraping Demos](https://github.com/schwartstack/webscraping): Demo functions for web scraping using the RCurl and rvest packages.",
            ),
          ],
        ),
        CollapsibleSection(
          title: "Python Projects",
          children: [
            HyperLink(
              linkStyle: linkStyle,
              text:
                  "• [Twitter Bots](https://github.com/schwartstack/TwitterBot): Several bots that posted at regular intervals on Twitter. They no longer work because Twitter has since changed to X and changed its API. But the fruits of my labor still remain at:",
            ),
            HyperLink(
              linkStyle: linkStyle,
              text: "    • [Band Name Bot](https://x.com/The_BandNameBot)",
            ),
            HyperLink(
              linkStyle: linkStyle,
              text: "    • [Board Game Bot](https://x.com/TheBoardgameBot)",
            ),
            HyperLink(
              linkStyle: linkStyle,
              text: "    • [Genre Bot](https://x.com/TheGenreBot)",
            ),
            HyperLink(
              linkStyle: linkStyle,
              text: "    • [I Tweet Lists](https://x.com/ItweetLists)",
            ),
            HyperLink(
              linkStyle: linkStyle,
              text: "    • [Portmanteau Bot](https://x.com/BadPortmanteaus)",
            ),
          ],
        ),
        CollapsibleSection(
          title: "School Projects",
          children: [
            HyperLink(
              linkStyle: linkStyle,
              text:
                  "• CAMCOS Presentation - [Finite Rank Deep Kernel Learning](https://schwartstack.github.io/docs/CAMCOS_project_finite_rank_deep_kernel_learning.pptx)",
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 5, bottom: 10),
              child: SelectableText(
                "CAMCOS is a student research program in the Department of Mathematics and Statistics at San Jose State University. Each semester, a new project is sponsored by a company, typically a Bay Area tech company, and a few of the top students are selected to participate at the recommendation of their professors. The project I participated in was sponsored by Intuit, and its purpose was to investigate cutting edge techniques in Deep Kernel Learning and Gaussian Process Regression.",
              ),
            ),
            HyperLink(
              linkStyle: linkStyle,
              text:
                  "• Categorical Data Analysis Project - [Analysis of the Vietnam War Draft Lottery](https://schwartstack.github.io/docs/categorical_data_analysis_project_draft_lottery.pdf)",
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 5, bottom: 10),
              child: SelectableText(
                "The assignment was to use data from the Vietnam war draft lottery do determine if the randomization process was truly random enough, or if the draft lottery was in any way unfair. On December 1, 1969, a lottery was held to determine the order of call to military service in the Vietnam war for men born between 1944 and 1950. First, the 31 days of January were written on slips of paper and inserted into separate cylindrical capsules. The capsules were then placed in a large wooden box and pushed to one side with a cardboard divider, leaving part of the box empty. Next, the 29 capsules for February were similarly prepared and poured into the empty portion of the box, counted again, and then scraped with the divider into the January capsules. The same process was followed with each subsequent month. After the 31 capsules for December were mixed with the other capsules, the box was shut, shook several times, and poured into a two-foot deep bowl. The capsules were then drawn successively from the bowl. The first date drawn, September 14, was assigned lottery number 1. The second date drawn, April 24, was assigned lottery number 2. This process was repeated until all of the capsules were drawn. The men were called for service in the order of the lottery numbers assigned to their days of birth.",
              ),
            ),
            HyperLink(
              linkStyle: linkStyle,
              text:
                  "• Categorical Data Analysis Project - [An Analysis of Student Opinion of Teaching Effectiveness Data](https://schwartstack.github.io/docs/categorical_data_analysis_project_student_opinion_of_teaching_effectiveness.pdf)",
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 5, bottom: 10),
              child: SelectableText(
                "The S.O.T.E. is essentially a survey given to students at San Jose State at the end of each semester to rate the professor of each class they have taken that semester. The purpose of this project was to analyze real life S.O.T.E. data to investigate what factors contribute to professors receiving high or low ratings from students.",
              ),
            ),
            HyperLink(
              linkStyle: linkStyle,
              text:
                  "• Experimental Design and Analysis Project - [Dice Superstitions](https://schwartstack.github.io/docs/design_of_experiments_project_dice_superstitions.pdf)",
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 5, bottom: 10),
              child: SelectableText(
                "The propose of the project was to design an experiment using the principles and techniques we had learned throughout the semester. The experiment had to be designed keeping in mind that we had to be able to conduct the experiment and collect the data ourselves with no budget. The idea behind our experiment was that we would perform various common gambling superstitions such as blowing on the dice, shouting something, blowing on the dice, etc. We would apply various combinations of superstitions, and record the results of the many, many dice rolls. The subsequent analysis would reveal whether or not there is any validity to any of the dice superstitions (which of course, there isn’t).",
              ),
            ),
            HyperLink(
              linkStyle: linkStyle,
              text:
                  "• Python Programming Project - [Classification of Political Tweets](https://schwartstack.github.io/docs/python_programming_project_classification_of_political_tweets.pdf)",
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 5, bottom: 10),
              child: SelectableText(
                "My team used data from Kaggle consisting of tweets from members of U.S. Congress. Our goal was to create a classification machine learning model in Python which could receive a new tweet and predict whether it was written by a Republican or by a Democrat.",
              ),
            ),
            HyperLink(
              linkStyle: linkStyle,
              text:
                  "• Regression Project - [YouTube Trending Video Analysis](https://schwartstack.github.io/docs/regression_project_youtube_trending_video_analysis.pdf)",
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 5, bottom: 10),
              child: SelectableText(
                "The purpose of this project was to apply the theory and techniques we had learned in Linear Regression on a real life data set. My team found a data set about trending viral videos on YouTube on Kaggle. We used data cleansing, variable transformation, feature extraction, variable selection, and model adequacy checking to build a linear regression model to explain what features of a viral video have the greatest effect on the number of views the video would get.",
              ),
            ),
            HyperLink(
              linkStyle: linkStyle,
              text:
                  "• Statistical Consulting Presentation - [Evaluating Normality and Constant Variance](https://schwartstack.github.io/docs/statistical_consulting_project_normality_and_constant_variance.pdf)",
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 5, bottom: 10),
              child: SelectableText(
                "Each group of two was given a topic which may have slipped through the cracks of the rest of the Masters of Statistics curriculum. My group’s presentation was about various tests and methods to evaluate whether or not a set of data came from a normally distributed population, and whether or not the data has constant variance; These are perhaps the two most common assumptions of many parametric statistical methods and hypothesis tests.",
              ),
            ),
            HyperLink(
              linkStyle: linkStyle,
              text:
                  "• Stochastic Processes Presentation - [Martingales](https://schwartstack.github.io/docs/stochastic_processes_project_martingales.pptx)",
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 5, bottom: 10),
              child: SelectableText(
                "Each student was to present on a topic in Stochastic Processes that interested them that we didn’t have time to get into properly throughout the semester. I chose to present on martingales because I have an interest in gambling, and I found the topic to be very easy to explain while also being very interesting both in theory and in application to gambling.",
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CollapsibleSection extends StatefulWidget {
  final String title;
  final List<Widget> children;

  const CollapsibleSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  State<CollapsibleSection> createState() => _CollapsibleSectionState();
}

class _CollapsibleSectionState extends State<CollapsibleSection> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Row(
            children: [
              Icon(
                _expanded
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_right,
              ),
              SelectableText(widget.title, style: headerStyle),
            ],
          ),
        ),
        if (_expanded) ...widget.children,
        const SizedBox(height: 20),
      ],
    );
  }
}
