
class ContactUs {

    String data;

    ContactUs({
       
        required this.data,
    });

    factory ContactUs.fromJson(Map<String, dynamic> json) => ContactUs(
      
        data: json["data"].toString(),
    );

    Map<String, dynamic> toJson() => {
      
        "data": data,
    };
}
