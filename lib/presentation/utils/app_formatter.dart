import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppFormatter {
  static MaskTextInputFormatter longitudeOrLatitudeFormatter = MaskTextInputFormatter(
    mask: '##.######',
    filter: {'#': RegExp('[0-9]')},
  );
}
