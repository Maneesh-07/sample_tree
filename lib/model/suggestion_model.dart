class GetSuggestion {
  String data;

  GetSuggestion({
    required this.data,
  });

  factory GetSuggestion.fromJson(Map<String, dynamic> json) => GetSuggestion(
        data: json["data"].toString(), 
      );

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}

