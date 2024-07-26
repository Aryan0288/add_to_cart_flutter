import 'package:add_to_cart/pages/catalog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();

  submitHandler() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(context,MaterialPageRoute(builder: (context) =>const CatalogPage(),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/images/login_image.png"),
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 64),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              icon: Icon(CupertinoIcons.person),
                              labelText: "Username",
                              hintText: "Username"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username is required';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              icon: Icon(CupertinoIcons.padlock),
                              labelText: "Password",
                              hintText: "password"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'password is required';
                            }
                            if (value.length < 6) {
                              return 'password length must be 6';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  )),
              ElevatedButton(
                onPressed: submitHandler,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                child: "Login".text.white.make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
