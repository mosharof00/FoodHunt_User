class FoodStaticModel {
  final String? id;
  final String? name;
  final String? restaurantName;
  final String? sellerName;
  final String? imageUrl;
  final String? restaurantImageUrl;
  final String? sellerImageUrl;
  final double? rating;
  final int? numberOfRatings;
  final double? price;
  final DateTime? deliveryTime;
  final String? duration;
  final double? distance;
  final int? quantity;
  final int? availableQuantity;
  final bool? isAvailable;
  final String? shortDescription;
  final double? discount;

  FoodStaticModel({
    this.id,
    this.name,
    this.restaurantName,
    this.sellerName,
    this.imageUrl,
    this.restaurantImageUrl,
    this.sellerImageUrl,
    this.rating,
    this.numberOfRatings,
    this.price,
    this.deliveryTime,
    this.duration,
    this.distance,
    this.quantity,
    this.availableQuantity,
    this.isAvailable,
    this.shortDescription,
    this.discount,
  });

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'restaurantName': restaurantName,
      'sellerName': sellerName,
      'imageUrl': imageUrl,
      'restaurantImageUrl': restaurantImageUrl,
      'sellerImageUrl': sellerImageUrl,
      'rating': rating,
      'numberOfRatings': numberOfRatings,
      'price': price,
      'deliveryTime': deliveryTime?.toIso8601String(),
      'duration': duration,
      'distance': distance,
      'quantity': quantity,
      'availableQuantity': availableQuantity,
      'isAvailable': isAvailable,
      'shortDescription': shortDescription,
      'discount': discount,
    };
  }

  // Create model from JSON
  factory FoodStaticModel.fromJson(Map<String, dynamic> json) {
    return FoodStaticModel(
      id: json['id'],
      name: json['name'],
      restaurantName: json['restaurantName'],
      sellerName: json['sellerName'],
      imageUrl: json['imageUrl'],
      restaurantImageUrl: json['restaurantImageUrl'],
      sellerImageUrl: json['sellerImageUrl'],
      rating: json['rating']?.toDouble(),
      numberOfRatings: json['numberOfRatings'],
      price: json['price']?.toDouble(),
      deliveryTime: json['deliveryTime'] != null
          ? DateTime.parse(json['deliveryTime'])
          : null,
      duration: json['duration'],
      distance: json['distance']?.toDouble(),
      quantity: json['quantity'],
      availableQuantity: json['availableQuantity'],
      isAvailable: json['isAvailable'],
      shortDescription: json['shortDescription'],
      discount: json['discount']?.toDouble(),
    );
  }

  // Example usage based on the image
  factory FoodStaticModel.example() {
    return FoodStaticModel(
      id: '1',
      name: 'Chicken Hawaiian',
      restaurantName: 'tSwap',
      sellerName: 'Smith Clark',
      imageUrl: 'path_to_pizza_image.jpg',
      restaurantImageUrl: 'path_to_restaurant_logo.jpg',
      sellerImageUrl: 'path_to_seller_image.jpg',
      rating: 4.7,
      numberOfRatings: 25,
      price: 3.50,
      deliveryTime: DateTime(2025, 1, 22, 18, 15), // 6:15 PM
      duration: '10-15 mins',
      distance: 1.2,
      quantity: 1,
      availableQuantity: 3,
      isAvailable: true,
      shortDescription: 'Delicious Hawaiian pizza with chicken toppings',
      discount: 0.0,
    );
  }

  // Copy with method for easy object updates
  FoodStaticModel copyWith({
    String? id,
    String? name,
    String? restaurantName,
    String? sellerName,
    String? imageUrl,
    String? restaurantImageUrl,
    String? sellerImageUrl,
    double? rating,
    int? numberOfRatings,
    double? price,
    DateTime? deliveryTime,
    String? duration,
    double? distance,
    int? quantity,
    int? availableQuantity,
    bool? isAvailable,
    String? shortDescription,
    double? discount,
  }) {
    return FoodStaticModel(
      id: id ?? this.id,
      name: name ?? this.name,
      restaurantName: restaurantName ?? this.restaurantName,
      sellerName: sellerName ?? this.sellerName,
      imageUrl: imageUrl ?? this.imageUrl,
      restaurantImageUrl: restaurantImageUrl ?? this.restaurantImageUrl,
      sellerImageUrl: sellerImageUrl ?? this.sellerImageUrl,
      rating: rating ?? this.rating,
      numberOfRatings: numberOfRatings ?? this.numberOfRatings,
      price: price ?? this.price,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      duration: duration ?? this.duration,
      distance: distance ?? this.distance,
      quantity: quantity ?? this.quantity,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      isAvailable: isAvailable ?? this.isAvailable,
      shortDescription: shortDescription ?? this.shortDescription,
      discount: discount ?? this.discount,
    );
  }
}
