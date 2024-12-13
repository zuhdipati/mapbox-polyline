class Address {
    String? name;
    String? addressNumber;
    String? streetName;

    Address({
        this.name,
        this.addressNumber,
        this.streetName,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        name: json["name"] ?? '',
        addressNumber: json["address_number"] ?? '',
        streetName: json["street_name"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "address_number": addressNumber,
        "street_name": streetName,
    };
}
