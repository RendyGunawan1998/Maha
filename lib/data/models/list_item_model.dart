class ItemModel {
  final String kodeSku;
  final String namaBarang;
  final String foto;
  final int quantity;
  final double price;

  ItemModel({
    required this.kodeSku,
    required this.namaBarang,
    required this.foto,
    required this.quantity,
    required this.price,
  });

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      kodeSku: map['kode_sku'],
      namaBarang: map['nama_barang'],
      foto: map['foto'],
      quantity: map['quantity'],
      price: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'kode_sku': kodeSku,
      'nama_barang': namaBarang,
      'foto': foto,
      'quantity': quantity,
      'price': price,
    };
  }
}
