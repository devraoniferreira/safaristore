class Record {
  final String dtMov;
  final double valorTotalNf;
  final String dscCortesia;

  Record({
    required this.dtMov,
    required this.valorTotalNf,
    required this.dscCortesia,
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      dtMov: json['DT_MOV'],
      valorTotalNf: json['VALOR_TOTAL_NF'],
      dscCortesia: json['DSC_CORTESIA'],
    );
  }
}
