import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tul_shoppingcart/features/cart/data/repositories/firestore_repository.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CartApp(repository: FireStoreRepository()));
}
