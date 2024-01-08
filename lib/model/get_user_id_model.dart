
class GetCompanies {
    int id;
    String label;
    String icon;
    int userId;
    List<SocialLink> socialLinks;

    GetCompanies({
        required this.id,
        required this.label,
        required this.icon,
        required this.userId,
        required this.socialLinks,
    });

    factory GetCompanies.fromJson(Map<String, dynamic> json) => GetCompanies(
        id: json["id"],
        label: json["label"],
        icon: json["icon"],
        userId: json["user_id"],
        socialLinks: List<SocialLink>.from(json["social_links"].map((x) => SocialLink.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "icon": icon,
        "user_id": userId,
        "social_links": List<dynamic>.from(socialLinks.map((x) => x.toJson())),
    };
}

class SocialLink {
    int linkId;
    String url;

    SocialLink({
        required this.linkId,
        required this.url,
    });

    factory SocialLink.fromJson(Map<String, dynamic> json) => SocialLink(
        linkId: json["link_id"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "link_id": linkId,
        "url": url,
    };
}
