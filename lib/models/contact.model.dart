class Contact {
  Contact({required this.id, required this.name, this.photoURL});

  Contact.fromFirestore(Map<String, dynamic> data)
      : id = data[idKey],
        name = data[nameKey],
        photoURL = data[photoURLKey];

  static const idKey = 'id';
  static const nameKey = 'name';
  static const photoURLKey = 'photoURL';

  final String id;
  final String name;
  final String? photoURL;

  Map<String, dynamic> toFirestore() {
    final data = <String, dynamic>{idKey: id, nameKey: name};
    if (photoURL != null) {
      data[photoURLKey] = photoURL;
    }
    return data;
  }
}
