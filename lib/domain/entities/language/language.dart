import 'dart:convert';

class LanguageConfig {
  String mVersion = "";
  String mLang = "";
  Map<String, String> mLanguages = {};

  LanguageConfig.buildDefault();

  LanguageConfig(this.mVersion, this.mLang, this.mLanguages);

  factory LanguageConfig.fromJson(Map<String, dynamic> json) {
    Map<String, String> data = {};
    try {
      data = Map<String, String>.from(json['data']);
    } catch (e) {
      data = {};
    }
    return LanguageConfig(json['version'], json['lang'], data);
  }

  String toJson() {
    return "{\"version\": \"$mVersion\", \"lang\": \"$mLang\", \"data\": ${jsonEncode(mLanguages)}}";
  }
}