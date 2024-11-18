class CharacterModel {
  late int charId;
  late String charName;
  late String charStatus;
  late String charSpecies;
  late String charGender;
  late String charImage;
  late Map<String, dynamic> charLocations;
  late List<dynamic> charEpisode;
  CharacterModel.fromJson(Map<String, dynamic> json) {
    charId = json["id"];
    charName = json["name"];
    charStatus = json["status"];
    charSpecies = json["species"];
    charGender = json["gender"];
    charImage = json["image"];
    charLocations = json["location"];
    charEpisode = json["episode"];
  }
}
