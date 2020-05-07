import 'package:contact_list/src/model/dto/contact.dart';

class ContactMapper {
  static ContactDTO toDTO(Map map) {
    return ContactDTO(
      email: map['email'],
      id: map['id'],
      phone: map['phone'],
      img: map['img'],
      name: map['name'],
    );
  }

  static Map<String, dynamic> toMap(ContactDTO dto) {
    Map<String, dynamic> map = {
      'email': dto.email,
      'phone': dto.phone,
      'name': dto.name,
      'img': dto.img,
    };

    if(dto.id != null) map['id'] = dto.id;

    return map;
  }
}
