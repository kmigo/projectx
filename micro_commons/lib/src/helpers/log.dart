part of 'helpers.dart';
void logTitleCenter(String title , int length) {
  final lineLength = length;
  
  // Calcule o número de espaços em branco para preencher em cada lado
  int totalSpaces = lineLength - title.length;
  int padding = (totalSpaces / 2).floor();

  // Crie a linha de título
  String line = "${' ' * padding}$title${' ' * padding}";

  // Se a linha de título for um caractere mais curta devido ao arredondamento, adicione um espaço extra
  if (line.length < lineLength) {
    line = "$line ";
  }

  dev.log(line);
}