
import 'package:z1_keyboard/textfield_config.dart';

class FormRepository {

  Future<List<TextfieldConfig>> getTextFieldConfigs() async {
    return Future.delayed(Duration(milliseconds: 500), () => [
      TextfieldConfig(text: ""),
      TextfieldConfig(text: ""),
      TextfieldConfig(text: ""),
      TextfieldConfig(text: ""),
      TextfieldConfig(text: ""),
    ],);
  } 
}