
class GetSuggestion {
    String name;
    String phone;
    String email;

    GetSuggestion({
        required this.name,
        required this.phone,
        required this.email,
    });

    factory GetSuggestion.fromJson(Map<String, dynamic> json) => GetSuggestion(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
    };
}

