class Formulario {
  final int? id;
  final String? nombre;
  final String? codigo;
  static const String TABLENAME = "formularios";

  Formulario({this.id, this.nombre, this.codigo});

  Map<String, dynamic> toMap() {
    return {'id': id, 'nombre': nombre, 'codigo': codigo};
  }
}
