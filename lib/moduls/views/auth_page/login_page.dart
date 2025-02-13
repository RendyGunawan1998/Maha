import '../../../core.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  bool isChecked = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(14),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  AssetsHelper.icLogin1,
                  height: 60,
                  width: 100,
                ),
                hbox(10),
                textInter(
                    'Welcome to Login', Colors.black, FontWeight.w900, 20),
                hbox(40),
                Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textInter(
                            'Email / Phone', Colors.black, FontWeight.w500, 14),
                        hbox(4),
                        tfEmail('Email / Phone', emailController),
                        hbox(16),
                        textInter(
                            'Password', Colors.black, FontWeight.w500, 14),
                        hbox(4),
                        tfPass('Password', passwordController, obscureText, () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        }),
                      ],
                    )),
                Row(
                  children: [
                    Checkbox(
                      tristate: true,
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                    textInter(
                        'Keep Me Login', Colors.black, FontWeight.w600, 14),
                  ],
                ),
                hbox(40),
                loading == true
                    ? Center(child: CircularProgressIndicator())
                    : containerBlueButton('Login', () {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          final email = emailController.text;
                          final password = passwordController.text;
                          authController.loginUser(email, password, isChecked);
                          setState(() {
                            loading = false;
                          });
                        } else {
                          Get.snackbar('Field Empty',
                              'Please fill the form with some text');
                        }
                      }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
