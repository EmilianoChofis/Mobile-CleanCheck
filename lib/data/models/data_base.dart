abstract class DataBase {
  DataBase();

  factory DataBase.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError('fromJson() debe implementarse en subclases');
  }
}
