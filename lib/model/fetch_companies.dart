
class FetchCompanies {
    int id;
    int userId;
    String name;
    String phone;
    String logo;
    int countryId;
    int cityId;
    int isActive;
    String autoUrl;
    String uuid;
    String password;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;

    FetchCompanies({
        required this.id,
        required this.userId,
        required this.name,
        required this.phone,
        required this.logo,
        required this.countryId,
        required this.cityId,
        required this.isActive,
        required this.autoUrl,
        required this.uuid,
        required this.password,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
    });

    factory FetchCompanies.fromJson(Map<String, dynamic> json) => FetchCompanies(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        phone: json["phone"],
        logo: json["logo"],
        countryId: json["country_id"],
        cityId: json["city_id"],
        isActive: json["is_active"],
        autoUrl: json["auto_url"],
        uuid: json["uuid"],
        password: json["password"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "phone": phone,
        "logo": logo,
        "country_id": countryId,
        "city_id": cityId,
        "is_active": isActive,
        "auto_url": autoUrl,
        "uuid": uuid,
        "password": password,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
    };
}
