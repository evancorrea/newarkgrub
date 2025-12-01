class Location {
  final double lat;
  final double lng;
  final String address;

  Location({
    required this.lat,
    required this.lng,
    required this.address,
  });

  Location copyWith({
    double? lat,
    double? lng,
    String? address,
  }) {
    return Location(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
      'address': address,
    };
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'],
      lng: json['lng'],
      address: json['address'],
    );
  }
}

class FoodTruck {
  final int id;
  final String name;
  final String cuisine;
  final String description;
  final double rating;
  final String priceRange;
  final String hours;
  final String phone;
  final Location location;

  FoodTruck({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.description,
    required this.rating,
    required this.priceRange,
    required this.hours,
    required this.phone,
    required this.location,
  });

  FoodTruck copyWith({
    int? id,
    String? name,
    String? cuisine,
    String? description,
    double? rating,
    String? priceRange,
    String? hours,
    String? phone,
    Location? location,
  }) {
    return FoodTruck(
      id: id ?? this.id,
      name: name ?? this.name,
      cuisine: cuisine ?? this.cuisine,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      priceRange: priceRange ?? this.priceRange,
      hours: hours ?? this.hours,
      phone: phone ?? this.phone,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cuisine': cuisine,
      'description': description,
      'rating': rating,
      'priceRange': priceRange,
      'hours': hours,
      'phone': phone,
      'location': location.toJson(),
    };
  }

  factory FoodTruck.fromJson(Map<String, dynamic> json) {
    return FoodTruck(
      id: json['id'],
      name: json['name'],
      cuisine: json['cuisine'],
      description: json['description'],
      rating: json['rating'].toDouble(),
      priceRange: json['priceRange'],
      hours: json['hours'],
      phone: json['phone'],
      location: Location.fromJson(json['location']),
    );
  }
}
