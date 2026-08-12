class LlaveData {
  final int numero;
  final String estado;
  final String? profesor;
  final int pabellon;

  LlaveData({
    required this.numero,
    required this.estado,
    this.profesor,
    required this.pabellon,
  });

  factory LlaveData.fromJson(Map<String, dynamic> json) {
    return LlaveData(
      numero: int.tryParse(json['llave'].toString()) ?? 0,
      estado: json['estado'].toString(),
      profesor: json['profesor']?.toString(),
      pabellon: int.tryParse(json['pabellon'].toString()) ?? 0,
    );
  }
}

class Pabellon {
  final int id;

  Pabellon({required this.id});

  factory Pabellon.fromJson(Map<String, dynamic> json) {
    final id = int.tryParse(json['idpabellones'].toString()) ?? 0;
    return Pabellon(
      id: id,
    );
  }
}