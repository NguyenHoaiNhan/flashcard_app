class EnglishToday {
  String? id;
  String? noun;
  String? quote; // example
  bool isFavorite;
  String? definition;
  String? category;
  String? ipa;

  EnglishToday(
      {this.id,
      this.noun,
      this.quote,
      this.isFavorite = false,
      this.definition,
      this.category,
      this.ipa});
}
