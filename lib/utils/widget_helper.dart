import 'dart:io';

import '../core.dart';

AppBar appbarImage(String title1, String title2) {
  return AppBar(
      leading: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Image.asset(
          AssetsHelper.imgProfile,
          height: 15,
          width: 15,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textInter(title1, Colors.black, FontWeight.w700, 16),
          textInter(title2, Colors.black87, FontWeight.w300, 14),
        ],
      ));
}

AppBar appbarHome(String title1, String title2, Function() funcLogout) {
  return AppBar(
    leading: Padding(
      padding: EdgeInsets.only(left: 10),
      child: Image.asset(
        AssetsHelper.imgProfile,
        height: 15,
        width: 15,
      ),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textInter(title1, Colors.black, FontWeight.w700, 16),
        textInter(title2, Colors.black87, FontWeight.w300, 14),
      ],
    ),
    actions: [
      Padding(
        padding: EdgeInsets.only(right: 15),
        child: InkWell(
          onTap: funcLogout,
          child: Icon(
            Icons.logout,
            color: Colors.red,
          ),
        ),
      )
    ],
  );
}

AppBar appbarImageLogin(String title1, String title2, Function() funcLogin) {
  return AppBar(
    leading: Padding(
      padding: EdgeInsets.only(left: 10),
      child: Image.asset(
        AssetsHelper.imgProfile,
        height: 15,
        width: 15,
      ),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textInter(title1, Colors.black, FontWeight.w700, 16),
        textInter(title2, Colors.black87, FontWeight.w300, 14),
      ],
    ),
    actions: [
      InkWell(
        onTap: funcLogin,
        child: Padding(
          padding: EdgeInsets.only(right: 15),
          child: Image.asset(
            AssetsHelper.icLogin2,
          ),
        ),
      )
    ],
  );
}

tffSearch(TextEditingController cont, String label, IconData icon,
    Function() funcSuff) {
  return Container(
    height: 35,
    padding: EdgeInsets.fromLTRB(14, 8, 5, 4),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 1)),
    child: TextField(
      controller: cont,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: label,
        suffixIcon: InkWell(onTap: funcSuff, child: Icon(icon)),
      ),
    ),
  );
}

Row iconRowEditDelete(Function() funcEdit, Function() funcDelete) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      InkWell(
          onTap: funcEdit,
          child: Image.asset(
            AssetsHelper.icEditing,
            height: 22,
          )),
      wbox(10),
      InkWell(
          onTap: funcDelete,
          child: Image.asset(
            AssetsHelper.icBin,
            height: 22,
          )),
      wbox(10),
    ],
  );
}

Column columnData(ItemModel item) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      textInter(item.namaBarang, Colors.black, FontWeight.w600, 14),
      hbox(2),
      textInter(item.kodeSku, Colors.black87, FontWeight.w400, 12),
      hbox(2),
      textInter('Rp ${oCcy.format(item.price)} /pcs', Colors.black87,
          FontWeight.w400, 12),
      hbox(2),
      textInter('Qty ${item.quantity}', Colors.black87, FontWeight.w400, 12),
      hbox(8),
    ],
  );
}

Container imageContainer(ItemModel item) {
  return Container(
    height: 80,
    width: 80,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black87, width: 1),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: isAssetImage(item.foto)
          ? Image.asset(
              item.foto,
              fit: BoxFit.cover,
            )
          : Image.file(File(item.foto)),
    ),
  );
}

Divider dividerCustom() {
  return Divider(
    indent: 90,
    color: Colors.black,
    thickness: 2,
  );
}

containerButton(String title, Function() func) {
  return InkWell(
    onTap: func,
    child: Container(
      height: 30,
      decoration: BoxDecoration(
          color: Colors.cyan[100], borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.fromLTRB(15, 6, 15, 6),
      child: Center(
        child: textInter(title, Colors.black87, FontWeight.bold, 14),
      ),
    ),
  );
}

containerBlueButton(String title, Function() func) {
  return InkWell(
    onTap: func,
    child: Container(
      // height: 30,
      decoration: BoxDecoration(
          color: Colors.blue[300], borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Center(
        child: textInter(title, Colors.black87, FontWeight.bold, 18),
      ),
    ),
  );
}

tff(TextEditingController cont, String label) {
  return TextField(
    controller: cont,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    ),
  );
}

tfPass(String hint, TextEditingController cont, bool stat, Function() func) {
  return Container(
    width: Get.width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black54, width: 0.5)),
    child: Padding(
      padding: EdgeInsets.only(left: 4, right: 4),
      child: TextFormField(
        controller: cont,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Password can't be null";
          }
          return null;
        },
        decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: func,
              child: Icon(stat ? Icons.visibility : Icons.visibility_off),
            ),
            hintText: 'Password',
            prefixIcon: Icon(Icons.lock_outline_rounded),
            contentPadding: EdgeInsets.only(top: 12, bottom: 10),
            border: InputBorder.none),
        obscureText: stat,
      ),
    ),
  );
}

tfEmail(String hint, TextEditingController cont) {
  return Container(
    width: Get.width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black54, width: 0.5)),
    child: Padding(
      padding: EdgeInsets.only(left: 4, right: 4),
      child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Email can't be null";
            }
            return null;
          },
          controller: cont,
          decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(Icons.email),
              contentPadding: EdgeInsets.only(top: 12, bottom: 10),
              border: InputBorder.none)),
    ),
  );
}

tffType(TextEditingController cont, String label, TextInputType type) {
  return TextField(
    controller: cont,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    ),
    keyboardType: type,
  );
}
