import 'package:mappbox_app/models/address_model.dart';

import 'country_model.dart';
import 'region_model.dart';

class SuggestSearchModel {
    List<SuggestionModel> suggestions;
    String attribution;
    String responseId;
    String url;

    SuggestSearchModel({
        required this.suggestions,
        required this.attribution,
        required this.responseId,
        required this.url,
    });

    factory SuggestSearchModel.fromJson(Map<String, dynamic> json) => SuggestSearchModel(
        suggestions: List<SuggestionModel>.from(json["suggestions"].map((x) => SuggestionModel.fromJson(x))),
        attribution: json["attribution"],
        responseId: json["response_id"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "suggestions": List<dynamic>.from(suggestions.map((x) => x.toJson())),
        "attribution": attribution,
        "response_id": responseId,
        "url": url,
    };
}

class SuggestionModel {
    String? name;
    String? mapboxId;
    String? featureType;
    String? address;
    String? fullAddress;
    String? placeFormatted;
    ContextModel? context;
    String? language;
    String? maki;
    List<String>? poiCategory;
    List<String>? poiCategoryIds;
    ExternalIds? externalIds;
    Metadata? metadata;
    int? distance;
    String? operationalStatus;

    SuggestionModel({
        this.name,
        this.mapboxId,
        this.featureType,
        this.address,
        this.fullAddress,
        this.placeFormatted,
        this.context,
        this.language,
        this.maki,
        this.poiCategory,
        this.poiCategoryIds,
        this.externalIds,
        this.metadata,
        this.distance,
        this.operationalStatus,
    });

    factory SuggestionModel.fromJson(Map<String, dynamic> json) => SuggestionModel(
        name: json["name"] ?? '',
        mapboxId: json["mapbox_id"]?? '',
        featureType: json["feature_type"]?? '',
        address: json["address"]?? '',
        fullAddress: json["full_address"]?? '',
        placeFormatted: json["place_formatted"]?? '',
        context: ContextModel.fromJson(json["context"]),
        language: json["language"]?? '',
        maki: json["maki"]?? '',
        poiCategory: json["poi_category"] == null ? null : List<String>.from(json["poi_category"].map((x) => x)),
        poiCategoryIds: json["poi_category_ids"] == null ? null : List<String>.from(json["poi_category_ids"].map((x) => x)),
        externalIds: json["external_ids"] == null ? null : ExternalIds.fromJson(json["external_ids"]),
        metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
        distance: json["distance"] ?? 0,
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
        "language": language,
        "maki": maki,
        "poi_category": List<dynamic>.from(poiCategory!.map((x) => x)),
        "poi_category_ids": List<dynamic>.from(poiCategoryIds!.map((x) => x)),
        "external_ids": externalIds?.toJson(),
        "metadata": metadata?.toJson(),
        "distance": distance,
        "operational_status": operationalStatus,
    };
}

class ContextModel {
    Country? country;
    Region? region;
    Place? postcode;
    Place? place;
    Place? locality;
    Place? neighborhood;
    Address? address;
    Street? street;

    ContextModel({
        this.country,
        this.region,
        this.postcode,
        this.place,
        this.locality,
        this.neighborhood,
        this.address,
        this.street,
    });

    factory ContextModel.fromJson(Map<String, dynamic> json) => ContextModel(
        country: json["country"] == null ? null : Country.fromJson(json["country"]),
        region: json["region"] == null ? null : Region.fromJson(json["region"]),
        postcode: json["postcode"] == null ? null : Place.fromJson(json["postcode"]),
        place: json["place"] == null ? null : Place.fromJson(json["place"]),
        locality: json["locality"] == null ? null : Place.fromJson(json["locality"]),
        neighborhood: json["neighborhood"] == null ? null : Place.fromJson(json["neighborhood"]),
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        street: json["street"] == null ? null : Street.fromJson(json["street"]),
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

class Place {
    String? id;
    String? name;

    Place({
        this.id,
        this.name,
    });

    factory Place.fromJson(Map<String, dynamic> json) => Place(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class Street {
    String? name;

    Street({
         this.name,
    });

    factory Street.fromJson(Map<String, dynamic> json) => Street(
        name: json["name"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class ExternalIds {
    String? dataplor;

    ExternalIds({
         this.dataplor,
    });

    factory ExternalIds.fromJson(Map<String, dynamic> json) => ExternalIds(
        dataplor: json["dataplor"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "dataplor": dataplor,
    };
}

class Metadata {
    Metadata();

    factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    );

    Map<String, dynamic> toJson() => {
    };
}
