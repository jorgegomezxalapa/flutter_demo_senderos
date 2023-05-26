class Credencial {
  int? id;
  int? activo;
  int? userCoreId;
  String? usuario;
  String? password;
  String? nombre;
  String? primerApellido;
  String? segundoApellido;
  String? token;

  static const String TABLENAME = "credenciales";

  Credencial(
      {this.id,
      this.activo,
      this.userCoreId,
      this.usuario,
      this.password,
      this.nombre,
      this.primerApellido,
      this.segundoApellido,
      this.token});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'activo': activo,
      'userCoreId': userCoreId,
      'usuario': usuario,
      'password': password,
      'nombre': nombre,
      'primerApellido': primerApellido,
      'segundoApellido': segundoApellido,
      'token': token,
    };
  }
}
