class AppUser {
  final String uid;
  final String fullName;
  final String email;
  final String image;
  final List<Map<String, dynamic>> favorites;
  final List<Map<String, dynamic>> cart;

  AppUser({
    required this.uid,
    required this.fullName,
    required this.email,
    this.image = '',
    List<Map<String, dynamic>>? favorites,
    List<Map<String, dynamic>>? cart,
  })  : favorites = favorites ?? [],
        cart = cart ?? [];

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'],
      fullName: json['fullName'],
      email: json['email'],
      image: json['image'] ?? '',
      favorites: (json['favorites'] as List<dynamic>?)
              ?.map((item) => Map<String, dynamic>.from(item))
              .toList() ??
          [],
      cart: (json['cart'] as List<dynamic>?)
              ?.map((item) => Map<String, dynamic>.from(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'image': image,
      'favorites': favorites,
      'cart': cart,
    };
  }

  AppUser copyWith({
    String? uid,
    String? fullName,
    String? email,
    String? image,
    List<Map<String, dynamic>>? favorites,
    List<Map<String, dynamic>>? cart,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      image: image ?? this.image,
      favorites: favorites ?? this.favorites,
      cart: cart ?? this.cart,
    );
  }
}
