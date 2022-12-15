class WebtoonDetailModel {
  final String title, about, genre, age;

  // webtoon detail model will take the json and will assign the title, about, genre and age
  WebtoonDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        about = json['about'],
        genre = json['genre'],
        age = json['age'];
}
