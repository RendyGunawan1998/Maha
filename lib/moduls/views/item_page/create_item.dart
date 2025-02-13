import 'dart:io';

import '../../../core.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  File? imageFile;
  final CameraService cameraService = CameraService();
  final formKey = GlobalKey<FormState>();
  final kode = TextEditingController();
  final nama = TextEditingController();
  final qty = TextEditingController();
  final harga = TextEditingController();
  ItemController controller = ItemController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getImageFromCamera() async {
    final image = await cameraService.pickImageFromCamera();
    if (image != null) {
      setState(() {
        imageFile = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarImage("List Item", 'Create'),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              children: [
                hbox(20),
                tff(kode, 'SKU Code'),
                hbox(10),
                tff(nama, 'Product Name'),
                hbox(10),
                tff(qty, 'Qty'),
                hbox(10),
                tff(harga, 'Price'),
                hbox(10),
                containerBlueButton('Pick Image', () {
                  getImageFromCamera();
                }),
                imageFile != null ? hbox(10) : hbox(0),
                imageFile != null
                    ? Image.file(
                        imageFile!,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                    : hbox(0),
                hbox(20),
                loading == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : containerBlueButton('Create New Item', () {
                        if (formKey.currentState!.validate()) {
                          if (imageFile != null) {
                            setState(() {
                              loading = true;
                            });

                            final addItem = ItemModel(
                                kodeSku: kode.text,
                                namaBarang: nama.text,
                                foto: imageFile!.path,
                                quantity: int.tryParse(qty.text) ?? 0,
                                price: double.tryParse(harga.text) ?? 0.0);

                            controller.createItem(addItem);
                            setState(() {
                              loading = false;
                            });
                            Get.offAll(() => ItemListPage());
                          } else {
                            Get.snackbar(
                                'Photo null', 'Please pick some image first');
                          }
                        } else {
                          Get.snackbar('Field Empty',
                              'Please fill the form with some text');
                        }
                      })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
