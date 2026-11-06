import 'package:flutter/material.dart';

import 'package:hyperlink/hyperlink.dart';

import 'package:home_page/styles.dart';

class PublicationsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(left: 20, top: 20),
      children: [
        SelectableText(
          "MLStar: A System for Synthesis of Machine-Learning Programs",
          style: titleStyle,
        ),
        SelectableText(
          "Kopito G, Schwartz J, Amblard J, Filman R, & Rabern L\nGECCO '23 Companion: Proceedings of the Companion Conference on Genetic and Evolutionary Computation, 2023, (1721-1726)",
        ),
        HyperLink(
          linkStyle: linkStyle,
          text:
              "[https://dl.acm.org/doi/10.1145/3583133.3596367](https://dl.acm.org/doi/10.1145/3583133.3596367)",
        ),
        SizedBox(height: 20),
        SelectableText(
          "Observational Cohort Study of Long-Term Outcomes of Liver Transplantation in Haemophilia",
          style: titleStyle,
        ),
        SelectableText(
          "Ragni VM, Callis J, Daoud N, Hu B, Manuel M, Santos J, Schwartz J, Friedman KD, Kouides P, Kuriakose P, Leavitt AD, Lim MY, Machin N, Recht M, & Chrisentery-Singleton T\nThe Official Journal of the World Federation of Hemophilia, 2023, (30(1), 87-97)",
        ),
        HyperLink(
          linkStyle: linkStyle,
          text:
              "[https://onlinelibrary.wiley.com/doi/10.1111/hae.14910](https://onlinelibrary.wiley.com/doi/10.1111/hae.14910)",
        ),
        SizedBox(height: 20),
        SelectableText(
          "Hereditary Antithrombin Deficiency Pilot Project Registry from the American Thrombosis and Hemostasis Network",
          style: titleStyle,
        ),
        SelectableText(
          "DeSancho MT, Suvar E, Roberts JC, Tarantino MD, Schwartz J, Callis J, & Recht MJ\nJournal of Thrombosis and Haemostasis, 2024, (22(11), 3183-3190)",
        ),
        HyperLink(
          linkStyle: linkStyle,
          text:
              "[https://pubmed.ncbi.nlm.nih.gov/39151704/](https://pubmed.ncbi.nlm.nih.gov/39151704/)",
        ),
      ],
    );
  }
}
