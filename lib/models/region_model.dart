
class Region {
    String? id;
    String? name;
    String? regionCode;
    String? regionCodeFull;

    Region({
        this.id,
        this.name,
        this.regionCode,
        this.regionCodeFull,
    });

    factory Region.fromJson(Map<String, dynamic> json) => Region(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        regionCode: json["region_code"] ?? '',
        regionCodeFull: json["region_code_full"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "region_code": regionCode,
        "region_code_full": regionCodeFull,
    };
}