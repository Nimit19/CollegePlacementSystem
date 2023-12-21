import 'dart:io';

import 'package:flutter/material.dart';
import 'package:placement/screens/admin_bottom_navigation_bar.dart';
import 'package:placement/screens/start_screen.dart';

// import '../auth_checker.dart';
import '../provider/auth_provider.dart';
import '../widgets/user_image_picker.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _form = GlobalKey<FormState>();
  var _isLogin = true;
  var _isAuthenticating = false;

  var _enteredEmail = '';
  var _enteredPassword = '';
  File? _selectedImage;

  void _submit(BuildContext context) async {
    var isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    if (!_isLogin && _selectedImage == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image is not selected'),
        ),
      );
      return;
    }

    _form.currentState!.save();

    final auth = ref.watch(authenticationProvider);

    setState(() {
      _isAuthenticating = true;
    });

    if (_isLogin) {
      await auth
          .signInWithEmailAndPassword(_enteredEmail, _enteredPassword, context)
          .whenComplete(
            () => auth.authStateChange.listen((event) async {
              if (event == null) {
                return;
              }

              if (auth.isAdmin(event.uid)) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const AdminBottomNavigationBar(),
                  ),
                );
              } else {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const StartScreen(),
                  ),
                );
              }
            }),
          );
    } else {
      await auth
          .signUpWithEmailAndPassword(_enteredEmail, _enteredPassword, context)
          .whenComplete(
            () => auth.authStateChange.listen((event) async {
              if (event == null) {
                return;
              }

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const StartScreen(),
                ),
              );

              final imageUrl = await auth.uploadImageToStorage(
                _selectedImage!,
                event.uid, // Use the user's UID as the image name
              );

              // Save the user's image URL to Firestore
              await auth.saveUserImage(
                event.uid,
                imageUrl,
              );
            }),
          );

      // final signupState = ref.read(signupStateProvider.notifier);
      // signupState.state = true;
    }
    setState(() {
      _isAuthenticating = false;
    });

    // final storageRef = FirebaseStorage.instance
    //     .ref()
    //     .child('user_images')
    //     .child('${userCredentials.user!.uid}.jpg');

    //     await storageRef.putFile(_selectedImage!);
    //     final imageUrl = await storageRef.getDownloadURL();

    //     await FirebaseFirestore.instance
    //         .collection('users')
    //         .doc(userCredentials.user!.uid)
    //         .set({
    //       'username': _enteredUsername,
    //       'email': _enteredEmail,
    //       'image_url': imageUrl
    //     });
    //   }

    // } on FirebaseAuthException catch (error) {
    //   if (error.code == 'email-already-in-use') {
    //     // if we want to give specific message to specific error
    //   }

    //   ScaffoldMessenger.of(context).clearSnackBars();
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(error.message ?? 'Authentication failed'),
    //     ),
    //   );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      top: 38,
                    ),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_isLogin)
                            UserImagePicker(
                              onPickImage: (pickedImage) {
                                _selectedImage = pickedImage;
                              },
                            ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(Icons.email),
                              label: const Text("E-mail"),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return "Please enter a valid Email";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                          if (!_isLogin)
                            const SizedBox(
                              height: 15,
                            ),
                          if (!_isLogin)
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                label: const Text("Username"),
                                prefixIcon: const Icon(Icons.person),
                              ),
                              enableSuggestions: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().length < 4) {
                                  return "Please enter at least 4 characters";
                                }
                                return null;
                              },
                              onSaved: (value) {},
                            ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              label: const Text("Password"),
                              prefixIcon: const Icon(Icons.lock),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          if (_isAuthenticating)
                            const CircularProgressIndicator(),
                          if (!_isAuthenticating)
                            ElevatedButton(
                              onPressed: () => _submit(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Text(_isLogin ? "Login" : "Signup"),
                            ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(_isLogin
                                ? "Create an account"
                                : "I already have an account"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
