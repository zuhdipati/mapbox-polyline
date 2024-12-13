class Country {
    String? name;
    String? countryCode;
    String? countryCodeAlpha3;

    Country({
        this.name,
        this.countryCode,
        this.countryCodeAlpha3,
    });

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json["name"] ?? '',
        countryCode: json["country_code"] ?? '',
        countryCodeAlpha3: json["country_code_alpha_3"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "country_code": countryCode,
        "country_code_alpha_3": countryCodeAlpha3,
    };
}