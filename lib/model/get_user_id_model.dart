class GetCompaniesLink {
    int id;
    String label;
    String icon;
    int categoryLabelId;
    int userId;
    CategoryLabel categoryLabel;
    List<SocialLink> socialLinks;

    GetCompaniesLink({
        required this.id,
        required this.label,
        required this.icon,
        required this.categoryLabelId,
        required this.userId,
        required this.categoryLabel,
        required this.socialLinks,
    });

    factory GetCompaniesLink.fromJson(Map<String, dynamic> json) => GetCompaniesLink(
        id: json["id"],
        label: json["label"],
        icon: json["icon"],
        categoryLabelId: json["category_label_id"],
        userId: json["user_id"],
        categoryLabel: CategoryLabel.fromJson(json["category_label"]),
        socialLinks: List<SocialLink>.from(json["social_links"].map((x) => SocialLink.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "icon": icon,
        "category_label_id": categoryLabelId,
        "user_id": userId,
        "category_label": categoryLabel.toJson(),
        "social_links": List<dynamic>.from(socialLinks.map((x) => x.toJson())),
    };
}

class CategoryLabel {
    int id;
    String name;
    int status;

    CategoryLabel({
        required this.id,
        required this.name,
        required this.status,
    });

    factory CategoryLabel.fromJson(Map<String, dynamic> json) => CategoryLabel(
        id: json["id"],
        name: json["name"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
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
