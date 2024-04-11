enum Gender {
  men,
  women,
}

class Sneaker {
  final String id;
  final String name;
  final String description;
  final String brand;
  final double price;
  final Gender gender;
  final Rating rating;
  final List<Variant> variants;

  Sneaker({
    required this.id,
    required this.name,
    required this.description,
    required this.brand,
    required this.price,
    required this.gender,
    required this.rating,
    required this.variants,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'brand': brand,
      'price': price,
      'gender': gender.toString().split('.').last,
      'rating': rating.toJson(),
      'variants': variants.map((variant) => variant.toJson()).toList(),
    };
  }

  factory Sneaker.fromJson(Map<String, dynamic> json) {
    return Sneaker(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      brand: json['brand'],
      price: json['price'].toDouble(),
      gender: Gender.values
          .firstWhere((e) => e.toString().split('.').last == json['gender']),
      rating: Rating.fromJson(json['rating']),
      variants: List<Variant>.from(
          json['variants'].map((variantJson) => Variant.fromJson(variantJson))),
    );
  }
}

class Rating {
  final double value;
  final int reviewsNumber;

  Rating({required this.value, required this.reviewsNumber});

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'reviewsNumber': reviewsNumber,
    };
  }

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      value: json['value'].toDouble(),
      reviewsNumber: json['reviewsNumber'],
    );
  }
}

class Variant {
  final String color;
  final List<String> images;
  final List<SizeStock> sizes;

  Variant({required this.color, required this.images, required this.sizes});

  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'images': images,
      'sizes': sizes.map((size) => size.toJson()).toList(),
    };
  }

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      color: json['color'],
      images: List<String>.from(json['images']),
      sizes: List<SizeStock>.from(
          json['sizes'].map((sizeJson) => SizeStock.fromJson(sizeJson))),
    );
  }
}

class SizeStock {
  final double size;
  final int stock;

  SizeStock({required this.size, required this.stock});

  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'stock': stock,
    };
  }

  factory SizeStock.fromJson(Map<String, dynamic> json) {
    return SizeStock(
      size: json['size'].toDouble(),
      stock: json['stock'],
    );
  }
}
