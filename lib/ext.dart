extension ExtractLanguage on String {
  String? extractLanguage() {
    final split = toLowerCase().split("intl_");
    if (split.length < 2) return null;

    switch (split[1]) {
      case "en.arb":
        return "English";
      case "it.arb":
        return "Italiano";
      case "fr.arb":
        return "Français";
      case "de.arb":
        return "Deutsch";
      default:
        return null;
    }
  }

  String? extractFilename() {
    switch (toLowerCase()) {
      case "english":
        return "intl_en.arb";
      case "italiano":
        return "intl_it.arb";
      case "français":
        return "intl_fr.arb";
      case "deutsch":
        return "intl_de.arb";
      default:
        return null;
    }
  }
}
