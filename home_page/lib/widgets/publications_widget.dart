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
          "Kopito, G., Schwartz, J., Amblard, J., Filman, R., & Rabern, L.\nGECCO '23 Companion: Proceedings of the Companion Conference on Genetic and Evolutionary Computation, 2023, (1721 – 1726)",
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
          "Ragni, V. M., Callis, J., Daoud, N., Hu, B., Manuel, M., Santos, J., Schwartz, J., Friedman, K. D., Kouides, P., Kuriakose, P., Leavitt, A. D., Lim, M. Y., Machin, N., Recht, M., Chrisentery-Singleton, T.\nThe Official Journal of the World Federation of Hemophilia, 2023, (30(1), 87-97)",
        ),
        HyperLink(
          linkStyle: linkStyle,
          text:
              "[https://onlinelibrary.wiley.com/doi/10.1111/hae.14910](https://onlinelibrary.wiley.com/doi/10.1111/hae.14910)",
        ),
      ],
    );
  }
}
