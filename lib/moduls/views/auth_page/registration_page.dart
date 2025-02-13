import '../../../core.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final AuthController authController = Get.put(AuthController());
  final nama = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final pass = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarImage('Registration', 'User'),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: EdgeInsets.all(14),
          child: SingleChildScrollView(
            child: Column(
              children: [
                tffType(nama, "Name", TextInputType.text),
                hbox(10),
                tffType(phone, "Phone Number", TextInputType.number),
                hbox(10),
                tffType(email, "Email", TextInputType.emailAddress),
                hbox(10),
                tffType(pass, "Password", TextInputType.text),
                hbox(30),
                loading == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : containerBlueButton('Registration', () async {
                        if (nama.text.isNotEmpty ||
                            phone.text.isNotEmpty ||
                            email.text.isNotEmpty ||
                            pass.text.isNotEmpty) {
                          setState(() {
                            loading = true;
                          });
                          await authController.registerUser(
                              nama.text, email.text, phone.text, pass.text);
                          setState(() {
                            loading = false;
                          });
                        } else {
                          Get.snackbar(
                              'Alert', 'Please check and fill the form');
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
