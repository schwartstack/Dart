import "package:band_namer/word_lists.dart";

class BandNameFactory {
  String construct() {
    String bandName = randomElement(WordLists.formulas);

    while (bandName.contains("NOUN[s]")) {
      bandName = bandName.replaceFirst(
        "NOUN[s]",
        pluralize(randomElement(WordLists.words["NOUN"]!)),
      );
    }

    while (bandName.contains("VERB[ers]")) {
      bandName = bandName.replaceFirst(
        "VERB[ers]",
        nounize(randomElement(WordLists.words["VERB"]!)),
      );
    }

    while (bandName.contains("VERB[ing]")) {
      bandName = bandName.replaceFirst(
        "VERB[ing]",
        gerundize(randomElement(WordLists.words["VERB"]!)),
      );
    }

    while (bandName.contains("ANY")) {
      bandName = bandName.replaceFirst(
        "ANY",
        randomElement(WordLists.allWords.toList()),
      );
    }

    for (String keyword in WordLists.words.keys) {
      RegExp match = RegExp(r"" + keyword);
      while (match.hasMatch(bandName)) {
        bandName = bandName.replaceFirst(
          keyword,
          randomElement(WordLists.words[keyword]!),
        );
      }
    }

    if (bandName.contains("[]")) {
      bandName = bandName
          .replaceFirst("[]", construct())
          .replaceAll("The The", "The");
    }

    return toTitleCase(bandName);
  }
}

String pluralize(String noun) {
  final attempts = [
    "${noun}s",
    "${noun}es",
    "${noun.substring(0, noun.length - 1)}ies",
  ];

  for (final attempt in attempts) {
    if (WordLists.allWords.contains(attempt)) {
      return attempt;
    }
  }
  return noun;
}

String gerundize(String verb) {
  final attempts = [
    "${verb}ing",
    "$verb${verb[verb.length - 1]}ing",
    "${verb.substring(0, verb.length - 1)}ing",
    "${verb.substring(0, verb.length - 2)}ing",
  ];

  for (final attempt in attempts) {
    if (WordLists.allWords.contains(attempt)) {
      return attempt;
    }
  }
  return verb;
}

String nounize(String verb) {
  final attempts = ["$verb${verb[verb.length - 1]}er", "${verb}r", "${verb}er"];

  for (final attempt in attempts) {
    if (WordLists.allWords.contains(attempt)) {
      return attempt;
    }
  }
  return verb;
}

String toTitleCase(String s) {
  List<String> exceptions = [
    "a",
    "an",
    "and",
    "as",
    "at",
    "but",
    "by",
    "for",
    "if",
    "in",
    "nor",
    "of",
    "on",
    "or",
    "out",
    "per",
    "so",
    "to",
    "up",
    "via",
    "yet",
  ];
  List<String> words = s.split(" ");
  String result = "";
  //   for (String word in words) {
  for (int i = 0; i < words.length; i++) {
    if (i == words.length - 1) {
      result += "${words[i][0].toUpperCase()}${words[i].substring(1)}";
    } else if (i == 0 || !exceptions.contains(words[i])) {
      result += "${words[i][0].toUpperCase()}${words[i].substring(1)} ";
    } else {
      result += "${words[i]} ";
    }
  }
  return result;
}
