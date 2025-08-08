import 'package:equatable/equatable.dart';

// Address model
class Address extends Equatable {
  final String id;
  final String addressLine1;
  final String? addressLine2;
  final String? landmark;
  final String city;
  final String state;
  final String country;
  final String pincode;
  final double? latitude;
  final double? longitude;
  final String formattedAddress;

  const Address({
    required this.id,
    required this.addressLine1,
    this.addressLine2,
    this.landmark,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
    this.latitude,
    this.longitude,
    this.formattedAddress = '',
  });

  Address copyWith({
    String? id,
    String? addressLine1,
    String? addressLine2,
    String? landmark,
    String? city,
    String? state,
    String? country,
    String? pincode,
    double? latitude,
    double? longitude,
    String? formattedAddress,
  }) {
    return Address(
      id: id ?? this.id,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      landmark: landmark ?? this.landmark,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      pincode: pincode ?? this.pincode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      formattedAddress: formattedAddress ?? this.formattedAddress,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'landmark': landmark,
      'city': city,
      'state': state,
      'country': country,
      'pincode': pincode,
      'latitude': latitude,
      'longitude': longitude,
      'formattedAddress': formattedAddress,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as String,
      addressLine1: json['addressLine1'] as String,
      addressLine2: json['addressLine2'] as String?,
      landmark: json['landmark'] as String?,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      pincode: json['pincode'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      formattedAddress: json['formattedAddress'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        addressLine1,
        addressLine2,
        landmark,
        city,
        state,
        country,
        pincode,
        latitude,
        longitude,
        formattedAddress,
      ];
}

// Address form data
class AddressFormData extends Equatable {
  final String addressLine1;
  final String? addressLine2;
  final String? landmark;
  final String city;
  final String state;
  final String country;
  final String pincode;
  final double? latitude;
  final double? longitude;

  const AddressFormData({
    required this.addressLine1,
    this.addressLine2,
    this.landmark,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
    this.latitude,
    this.longitude,
  });

  AddressFormData copyWith({
    String? addressLine1,
    String? addressLine2,
    String? landmark,
    String? city,
    String? state,
    String? country,
    String? pincode,
    double? latitude,
    double? longitude,
  }) {
    return AddressFormData(
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      landmark: landmark ?? this.landmark,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      pincode: pincode ?? this.pincode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'landmark': landmark,
      'city': city,
      'state': state,
      'country': country,
      'pincode': pincode,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory AddressFormData.fromJson(Map<String, dynamic> json) {
    return AddressFormData(
      addressLine1: json['addressLine1'] as String,
      addressLine2: json['addressLine2'] as String?,
      landmark: json['landmark'] as String?,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      pincode: json['pincode'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  @override
  List<Object?> get props => [
        addressLine1,
        addressLine2,
        landmark,
        city,
        state,
        country,
        pincode,
        latitude,
        longitude,
      ];
}

// Address state for Riverpod
class AddressState extends Equatable {
  final AddressStatus status;
  final Address? address;
  final String? error;

  const AddressState({
    this.status = AddressStatus.initial,
    this.address,
    this.error,
  });

  AddressState copyWith({
    AddressStatus? status,
    Address? address,
    String? error,
  }) {
    return AddressState(
      status: status ?? this.status,
      address: address ?? this.address,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, address, error];
}

enum AddressStatus { initial, loading, loaded, error }

// Base location model
class BaseLocation extends Equatable {
  final String id;
  final String name;

  const BaseLocation({
    required this.id,
    required this.name,
  });

  BaseLocation copyWith({
    String? id,
    String? name,
  }) {
    return BaseLocation(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory BaseLocation.fromJson(Map<String, dynamic> json) {
    return BaseLocation(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  @override
  List<Object?> get props => [id, name];
}

// Country model
class Country extends Equatable {
  final String id;
  final String name;
  final String? code;

  const Country({
    required this.id,
    required this.name,
    this.code,
  });

  Country copyWith({
    String? id,
    String? name,
    String? code,
  }) {
    return Country(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
    };
  }

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, name, code];
}

// State model
class State extends Equatable {
  final String id;
  final String name;
  final String countryId;

  const State({
    required this.id,
    required this.name,
    required this.countryId,
  });

  State copyWith({
    String? id,
    String? name,
    String? countryId,
  }) {
    return State(
      id: id ?? this.id,
      name: name ?? this.name,
      countryId: countryId ?? this.countryId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'countryId': countryId,
    };
  }

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      id: json['id'] as String,
      name: json['name'] as String,
      countryId: json['countryId'] as String,
    );
  }

  @override
  List<Object?> get props => [id, name, countryId];
}

// District model
class District extends Equatable {
  final String id;
  final String name;
  final String stateId;

  const District({
    required this.id,
    required this.name,
    required this.stateId,
  });

  District copyWith({
    String? id,
    String? name,
    String? stateId,
  }) {
    return District(
      id: id ?? this.id,
      name: name ?? this.name,
      stateId: stateId ?? this.stateId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'stateId': stateId,
    };
  }

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'] as String,
      name: json['name'] as String,
      stateId: json['stateId'] as String,
    );
  }

  @override
  List<Object?> get props => [id, name, stateId];
}

// City model
class City extends Equatable {
  final String id;
  final String name;
  final String districtId;

  const City({
    required this.id,
    required this.name,
    required this.districtId,
  });

  City copyWith({
    String? id,
    String? name,
    String? districtId,
  }) {
    return City(
      id: id ?? this.id,
      name: name ?? this.name,
      districtId: districtId ?? this.districtId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'districtId': districtId,
    };
  }

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] as String,
      name: json['name'] as String,
      districtId: json['districtId'] as String,
    );
  }

  @override
  List<Object?> get props => [id, name, districtId];
}

// Area model
class Area extends Equatable {
  final String id;
  final String name;
  final String cityId;
  final String? pincode;

  const Area({
    required this.id,
    required this.name,
    required this.cityId,
    this.pincode,
  });

  Area copyWith({
    String? id,
    String? name,
    String? cityId,
    String? pincode,
  }) {
    return Area(
      id: id ?? this.id,
      name: name ?? this.name,
      cityId: cityId ?? this.cityId,
      pincode: pincode ?? this.pincode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cityId': cityId,
      'pincode': pincode,
    };
  }

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      id: json['id'] as String,
      name: json['name'] as String,
      cityId: json['cityId'] as String,
      pincode: json['pincode'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, name, cityId, pincode];
}

// Location API response
class LocationAPIResponse<T> extends Equatable {
  final bool success;
  final String? message;
  final T? data;
  final LocationData<T>? locationData;

  const LocationAPIResponse({
    required this.success,
    this.message,
    this.data,
    this.locationData,
  });

  LocationAPIResponse<T> copyWith({
    bool? success,
    String? message,
    T? data,
    LocationData<T>? locationData,
  }) {
    return LocationAPIResponse<T>(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
      locationData: locationData ?? this.locationData,
    );
  }

  @override
  List<Object?> get props => [success, message, data, locationData];
}

// Location data
class LocationData<T> extends Equatable {
  final List<T> items;
  final LocationPagination pagination;

  const LocationData({
    required this.items,
    required this.pagination,
  });

  LocationData<T> copyWith({
    List<T>? items,
    LocationPagination? pagination,
  }) {
    return LocationData<T>(
      items: items ?? this.items,
      pagination: pagination ?? this.pagination,
    );
  }

  @override
  List<Object?> get props => [items, pagination];
}

// Location pagination
class LocationPagination extends Equatable {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const LocationPagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  LocationPagination copyWith({
    int? currentPage,
    int? totalPages,
    int? totalItems,
    int? itemsPerPage,
    bool? hasNextPage,
    bool? hasPreviousPage,
  }) {
    return LocationPagination(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'totalPages': totalPages,
      'totalItems': totalItems,
      'itemsPerPage': itemsPerPage,
      'hasNextPage': hasNextPage,
      'hasPreviousPage': hasPreviousPage,
    };
  }

  factory LocationPagination.fromJson(Map<String, dynamic> json) {
    return LocationPagination(
      currentPage: json['currentPage'] as int,
      totalPages: json['totalPages'] as int,
      totalItems: json['totalItems'] as int,
      itemsPerPage: json['itemsPerPage'] as int,
      hasNextPage: json['hasNextPage'] as bool,
      hasPreviousPage: json['hasPreviousPage'] as bool,
    );
  }

  @override
  List<Object?> get props => [
        currentPage,
        totalPages,
        totalItems,
        itemsPerPage,
        hasNextPage,
        hasPreviousPage,
      ];
}

// Create location request
class CreateLocationRequest extends Equatable {
  final String name;
  final String? parentId;
  final String type;

  const CreateLocationRequest({
    required this.name,
    this.parentId,
    required this.type,
  });

  CreateLocationRequest copyWith({
    String? name,
    String? parentId,
    String? type,
  }) {
    return CreateLocationRequest(
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'parentId': parentId,
      'type': type,
    };
  }

  factory CreateLocationRequest.fromJson(Map<String, dynamic> json) {
    return CreateLocationRequest(
      name: json['name'] as String,
      parentId: json['parentId'] as String?,
      type: json['type'] as String,
    );
  }

  @override
  List<Object?> get props => [name, parentId, type];
}