import 'package:mappbox_app/models/address_model.dart';
import 'package:mappbox_app/models/country_model.dart';

import 'region_model.dart';

class SuggestRetrieveModel {
    String type;
    List<FeatureModel> features;
    String attribution;
    String url;

    SuggestRetrieveModel({
        required this.type,
        required this.features,
        required this.attribution,
        required this.url,
    });

    factory SuggestRetrieveModel.fromJson(Map<String, dynamic> json) => SuggestRetrieveModel(
        type: json["type"],
        features: List<FeatureModel>.from(json["features"].map((x) => FeatureModel.fromJson(x))),
        attribution: json["attribution"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
        "url": url,
    };
}

class FeatureModel {
    String type;
    Geometry geometry;
    Properties properties;

    FeatureModel({
        required this.type,
        required this.geometry,
        required this.properties,
    });

    factory FeatureModel.fromJson(Map<String, dynamic> json) => FeatureModel(
        type: json["type"],
        geometry: Geometry.fromJson(json["geometry"]),
        properties: Properties.fromJson(json["properties"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "geometry": geometry.toJson(),
        "properties": properties.toJson(),
    };
}

class Geometry {
    List<double>? coordinates;
    String? type;

    Geometry({
        this.coordinates,
        this.type,
    });

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: json["coordinates"] == null ?  null : List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
        type: json["type"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
        "type": type,
    };
}

class Properties {
    String? name;
    String? mapboxId;
    String? featureType;
    String? address;
    String? fullAddress;
    String? placeFormatted;
    Context? context;
    Coordinates? coordinates;
    String? language;
    String? maki;
    List<String>? poiCategory;
    List<String>? poiCategoryIds;
    ExternalIds? externalIds;
    ExternalIds? metadata;
    String? operationalStatus;

    Properties({
        this.name,
        this.mapboxId,
        this.featureType,
        this.address,
        this.fullAddress,
        this.placeFormatted,
        this.context,
        this.coordinates,
        this.language,
        this.maki,
        this.poiCategory,
        this.poiCategoryIds,
        this.externalIds,
        this.metadata,
        this.operationalStatus,
    });

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        name: json["name"] ?? '',
        mapboxId: json["mapbox_id"] ?? '',
        featureType: json["feature_type"] ?? '',
        address: json["address"] ?? '',
        fullAddress: json["full_address"] ?? '',
        placeFormatted: json["place_formatted"] ?? '',
        context: json["context"] == null ? null : Context.fromJson(json["context"]),
        coordinates: json["coordinates"] == null ? null : Coordinates.fromJson(json["coordinates"]),
        language: json["language"] ?? '',
        maki: json["maki"] ?? '',
        poiCategory: json["poi_category"] == null ? null : List<String>.from(json["poi_category"].map((x) => x)),
        poiCategoryIds: json["poi_category_ids"] == null ? null : List<String>.from(json["poi_category_ids"].map((x) => x)),
        externalIds: json["external_ids"] == null ? null : ExternalIds.fromJson(json["external_ids"]),
        metadata: json["metadata"] == null ? null : ExternalIds.fromJson(json["metadata"]),
        operationalStatus: json["operational_status"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "mapbox_id": mapboxId,
        "feature_type": featureType,
        "address": address,
        "full_address": fullAddress,
        "place_formatted": placeFormatted,
        "context": context?.toJson(),
        "coordinates": coordinates?.toJson(),
        "language": language,
        "maki": maki,
        "poi_category": List<dynamic>.from(poiCategory!.map((x) => x)),
        "poi_category_ids": List<dynamic>.from(poiCategoryIds!.map((x) => x)),
        "external_ids": externalIds?.toJson(),
        "metadata": metadata?.toJson(),
        "operational_status": operationalStatus,
    };
}

class Context {
    Country? country;
    Region? region;
    Locality? postcode;
    Locality? place;
    Locality? locality;
    Locality? neighborhood;
    Address? address;
    Locality? street;

    Context({
        this.country,
        this.region,
        this.postcode,
        this.place,
        this.locality,
        this.neighborhood,
        this.address,
        this.street,
    });

    factory Context.fromJson(Map<String, dynamic> json) => Context(
        country: json["country"] == null ? null : Country.fromJson(json["country"]),
        region: json["region"] == null ? null : Region.fromJson(json["region"]),
        postcode: json["postcode"] == null ? null : Locality.fromJson(json["postcode"]),
        place: json["place"] == null ? null : Locality.fromJson(json["place"]),
        locality: json["locality"] == null ? null : Locality.fromJson(json["locality"]),
        neighborhood: json["neighborhood"] == null ? null : Locality.fromJson(json["neighborhood"]),
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        street: json["street"] == null ? null : Locality.fromJson(json["street"]),
    );

    Map<String, dynamic> toJson() => {
        "country": country?.toJson(),
        "region": region?.toJson(),
        "postcode": postcode?.toJson(),
        "place": place?.toJson(),
        "locality": locality?.toJson(),
        "neighborhood": neighborhood?.toJson(),
        "address": address?.toJson(),
        "street": street?.toJson(),
    };
}

class Locality {
    String id;
    String name;

    Locality({
        required this.id,
        required this.name,
    });

    factory Locality.fromJson(Map<String, dynamic> json) => Locality(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}


class Coordinates {
    double? latitude;
    double? longitude;
    List<RoutablePoint>? routablePoints;

    Coordinates({
        this.latitude,
        this.longitude,
        this.routablePoints,
    });

    factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"]?.toDouble() ?? 0.0,
        longitude: json["longitude"]?.toDouble() ?? 0.0,
        routablePoints:json["routable_points"] == null ? null : List<RoutablePoint>.from(json["routable_points"].map((x) => RoutablePoint.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "routable_points": List<dynamic>.from(routablePoints!.map((x) => x.toJson())),
    };
}

class RoutablePoint {
    String? name;
    double? latitude;
    double? longitude;

    RoutablePoint({
        this.name,
        this.latitude,
        this.longitude,
    });

    factory RoutablePoint.fromJson(Map<String, dynamic> json) => RoutablePoint(
        name: json["name"] ?? '',
        latitude: json["latitude"]?.toDouble() ?? 0.0,
        longitude: json["longitude"]?.toDouble() ?? 0.0,
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
    };
}

class ExternalIds {
    ExternalIds();

    factory ExternalIds.fromJson(Map<String, dynamic> json) => ExternalIds(
    );

    Map<String, dynamic> toJson() => {
    };
}
