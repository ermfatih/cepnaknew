import 'package:i18n_extension/i18n_extension.dart';
import 'package:i18n_extension_importer/i18n_extension_importer.dart';

class MyI18n {
  static TranslationsByLocale translations = Translations.byLocale("tr");
  static Future<void> loadTranslations() async {
    translations += await JSONImporter().fromAssetDirectory("assets/translation_json");
  }
}

extension Localization on String {
  String get i18n => localize(this, MyI18n.translations);
  String plural(value) => localizePlural(value, this, MyI18n.translations);
  String fill(List<Object> params) => localizeFill(this, params);
}
/*abstract class Importer {
  String get _extension;

  Map<String, String> _load(String source);

  Future<Map<String, Map<String, String>>> fromAssetFile(
      String language, String fileName) async {
    return {language: _load(await rootBundle.loadString(fileName))};
  }

  Future<Map<String, Map<String, String>>> fromAssetDirectory(
      String dir) async {
    var manifestContent = await rootBundle.loadString("AssetManifest.json");
    Map<String, dynamic> manifestMap = json.decode(manifestContent);

    Map<String, Map<String, String>> translations = HashMap();

    for (String path in manifestMap.keys) {
      if (!path.startsWith(dir)) continue;
      var fileName = path.split("/").last;
      if (!fileName.endsWith(_extension)) {
        // ignore: avoid_print
        print("➜ Ignoring file $path with unexpected file type "
            "(expected: $_extension).");
        continue;
      }
      var languageCode = fileName.split(".")[0];
      translations.addAll(await fromAssetFile(languageCode, path));
    }

    return translations;
  }
}

class JSONImporter extends Importer {
  @override
  String get _extension => ".json";

  @override
  Map<String, String> _load(String source) {
    return Map<String, String>.from(json.decode(source));
  }
}
*/
