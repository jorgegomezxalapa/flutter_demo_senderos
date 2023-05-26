//Logica para el selector de motivos
class SelectorMotivo {
  final int id;
  final String texto;

  SelectorMotivo(this.id, this.texto);
}

List<SelectorMotivo> motivosOpciones = [
  SelectorMotivo(0, 'Seleccionar'),
  SelectorMotivo(1, 'El domicilio señalado no existe'),
  SelectorMotivo(2, 'El domicilio no corresponde al centro de trabajo'),
  SelectorMotivo(3, 'Otro motivo')
];

class SelectorFormaConstatacion {
  final int id;
  final String texto;

  SelectorFormaConstatacion(this.id, this.texto);
}

List<SelectorFormaConstatacion> formasOpciones = [
  SelectorFormaConstatacion(0, 'Seleccionar'),
  SelectorFormaConstatacion(1, 'Nomenclatura de la calle y letrero visible en el exterior'),
  SelectorFormaConstatacion(2, 'Aviso de inscripcion al sat'),
  SelectorFormaConstatacion(3, 'Otra')
];