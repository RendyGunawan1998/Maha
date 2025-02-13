import 'dart:io';

import '../../../core.dart';

class EditItemScreen extends StatefulWidget {
  final ItemModel item;
  const EditItemScreen({super.key, required this.item});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
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

    nama.text = widget.item.namaBarang;
    qty.text = widget.item.quantity.toString();
    harga.text = widget.item.price.toString();
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
      appBar: appbarImage("List Item", 'Update'),
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
                    : containerBlueButton('Update Item', () {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });

                          final updatedItem = ItemModel(
                              kodeSku: widget.item.kodeSku,
                              namaBarang: nama.text,
                              foto: imageFile != null
                                  ? imageFile!.path
                                  : widget.item.foto,
                              quantity: int.tryParse(qty.text) ?? 0,
                              price: double.tryParse(harga.text) ?? 0.0);

                          controller.updateItem(
                              widget.item.kodeSku, updatedItem);
                          setState(() {
                            loading = false;
                          });
                          Get.offAll(() => ItemListPage());
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
