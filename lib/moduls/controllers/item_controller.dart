import '../../core.dart';

class ItemController extends GetxController {
  var items = <ItemModel>[].obs;
  final dbHelper = DatabaseHelper.instance;

  @override
  void onInit() {
    getItems();
    super.onInit();
  }

  Future<void> getItems() async {
    final result = await dbHelper.readItems();
    items.value = result.map((e) => ItemModel.fromMap(e)).toList();
  }

  Future<void> searchItems(String query) async {
    final result = await dbHelper.searchItems(query);
    items.value = result.map((e) => ItemModel.fromMap(e)).toList();
  }

  Future<void> createItem(ItemModel item) async {
    await dbHelper.createItem(item.toMap());
    getItems();
  }

  Future<void> updateItem(String kodeSku, ItemModel updatedItem) async {
    await dbHelper.updateItem(kodeSku, updatedItem.toMap());
    getItems();
  }

  Future<void> deleteItem(String kodeSku) async {
    await dbHelper.deleteItem(kodeSku);
    getItems();
  }
}
