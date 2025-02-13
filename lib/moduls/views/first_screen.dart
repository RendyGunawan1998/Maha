import '../../../core.dart';

class FirstItemPage extends StatefulWidget {
  const FirstItemPage({super.key});

  @override
  FirstItemPageState createState() => FirstItemPageState();
}

class FirstItemPageState extends State<FirstItemPage> {
  final ItemController itemController = Get.put(ItemController());
  final TextEditingController searchController = TextEditingController();
  final preferenceHelper = PreferenceHelper();
  bool? isRegistred;

  @override
  void initState() {
    super.initState();

    checkRegistred();
    itemController.getItems();
  }

  checkRegistred() async {
    Future.delayed(Duration(seconds: 2), () async {
      bool login = await preferenceHelper.getBoolValue(boolKeyLogin);
      isRegistred = await preferenceHelper.getBoolValue(boolKeyRegistred);
      if (login == true) {
        Get.offAll(() => ItemListPage());
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarImageLogin('List Item', 'Home', () {
        showDialogLoginRegister(
            context,
            isRegistred == false
                ? () {
                    Navigator.pop(context);
                    Get.snackbar('Alert',
                        'Please registration first before click login');
                  }
                : () {
                    Navigator.pop(context);
                    print('Go To Login');
                    Get.to(() => LoginPage());
                  }, () {
          Navigator.pop(context);
          print('Go To Registration');
          Get.to(() => RegistrationScreen());
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            imageContainer(item),
                            wbox(15),
                            columnData(item)
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
    );
  }
}
