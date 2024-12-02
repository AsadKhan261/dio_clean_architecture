class AutoCompletePlace {
  List<Results>? results;
  double? generationtimeMs;

  AutoCompletePlace({this.results, this.generationtimeMs});

  AutoCompletePlace.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
    generationtimeMs = json['generationtime_ms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['generationtime_ms'] = this.generationtimeMs;
    return data;
  }
}

class Results {
  String? name;
  double? latitude;
  double? longitude;
  String? country;

  Results(
      {
        this.name,
        this.latitude,
        this.longitude,
        this.country,});

  Results.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['country'] = this.country;
    return data;
  }
}
