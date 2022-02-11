abstract class BaseModel<T> {
  Map<String, dynamic> toMap();

  T fromObject(dynamic json);
}
