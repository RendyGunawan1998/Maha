import 'package:intl/intl.dart';
import '../core.dart';

final oCcy = NumberFormat("#,##0.00", "en_US");

textInter(String title, Color color, FontWeight fw, double fs) {
  return Text(title,
      style: GoogleFonts.inter(color: color, fontWeight: fw, fontSize: fs));
}

hbox(double h) {
  return SizedBox(height: h);
}

wbox(double w) {
  return SizedBox(width: w);
}

bool isAssetImage(String path) {
  return path.startsWith("assets/");
}

Future<void> showMyDialog(BuildContext context, String title, String subtitle,
    Function() funcYes) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: <Widget>[
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            onPressed: funcYes,
            child: Text('Yes'),
          ),
        ],
      );
    },
  );
}

Future<void> showDialogLoginRegister(
    BuildContext context, Function() funcLogin, Function() funcregis) async {
  return showDialog<void>(
    context: context,
    // barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        contentPadding: EdgeInsets.only(top: 10.0),
        content: Container(
          width: Get.width * 0.6,
          height: Get.width * 0.38,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                hbox(10),
                textInter(
                    'Login / Register', Colors.black, FontWeight.w600, 16),
                hbox(25),
                containerButton('Login', funcLogin),
                hbox(12),
                containerButton('Registration', funcregis),
              ],
            ),
          ),
        ),
      );
    },
  );
}
