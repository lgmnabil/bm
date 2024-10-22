class Character {
  late int id;
  late String name;
  late String status;
  late String species;
  late String type;
  late String gender;
  late Origin origin;
  late Location location;
  late String image;
  late List<dynamic> episode;
  late String createdAt;

  Character.fromJson(Map<String, dynamic> json) {
      id = json['id'];
    name = json['name'] ?? 'Unknown'; // Default value if null
    status = json['status'] ?? 'Unknown'; // Default value if null
    species = json['species'] ?? 'Unknown'; // Default value if null
    type = json['type'] ?? 'Unknown'; // Default value if null
    gender = json['gender'] ?? 'Unknown'; // Default value if null
    origin = Origin.fromJson(json['origin']); // Convert from JSON
    location = Location.fromJson(json['location']); // Convert from JSON
  image = json['image'] ?? ''; // Default value if null
    episode = json['episode'] ?? []; // Default value if null
    createdAt = json['createdAt'] ?? ''; // Default value if null
  }
}

class Origin {
  late String name;
  late String url;
  Origin.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}

class Location {
  late String name;
  late String url;
  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}
