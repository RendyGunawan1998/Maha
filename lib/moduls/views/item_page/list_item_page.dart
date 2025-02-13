import '../../../core.dart';

class ItemListPage extends StatefulWidget {
  const ItemListPage({super.key});

  @override
  ItemListPageState createState() => ItemListPageState();
}

class ItemListPageState extends State<ItemListPage> {
  final ItemController itemController = Get.put(ItemController());
  final TextEditingController searchController = TextEditingController();
  final preferenceHelper = PreferenceHelper();

  @override
  void initState() {
    super.initState();
    itemController.getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarHome('List Item', 'Home', () {
        showMyDialog(context, 'Logout?', 'Are you sure want to logout?',
            () async {
          await preferenceHelper.saveBoolValue(boolKeyLogin, false);
          Get.offAll(() => LoginPage());
        });
      }),
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 6, bottom: 6),
        child: Column(
          children: [
            tffSearch(searchController, 'Search By Name', Icons.search, () {
              itemController.searchItems(searchController.text);
            }),
            hbox(15),
            Expanded(
              child: Obx(() {
                if (itemController.items.isEmpty) {
                  return Center(child: Text('No items found'));
                }
                return ListView.builder(
                  itemCount: itemController.items.length,
                  itemBuilder: (context, index) {
                    final item = itemController.items[index];
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                imageContainer(item),
                                wbox(15),
                                columnData(item)
                              ],
                            ),
                            iconRowEditDelete(() {
                              Get.to(() => EditItemScreen(
                                    item: item,
                                  ));
                            }, () {
                              showMyDialog(context, 'Delete?',
                                  'Are you sure want to delete this item?', () {
                                itemController.deleteItem(item.kodeSku);
                                Navigator.pop(context);
                              });
                            })
                          ],
                        ),
                        dividerCustom(),
                        hbox(8),
                      ],
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        width: Get.width,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: containerBlueButton('+Create New Item', () {
            Get.to(() => AddItemScreen());
          }),
        ),
      ),
    );
  }
}
