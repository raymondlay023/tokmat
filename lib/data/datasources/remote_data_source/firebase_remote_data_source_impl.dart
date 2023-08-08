import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tokmat/core/const.dart';
import 'package:tokmat/data/models/product_model.dart';
import 'package:tokmat/data/models/shop_model.dart';
import 'package:tokmat/data/models/transaction_model.dart';
import 'package:tokmat/data/models/user_model.dart';
import 'package:tokmat/domain/entities/product_entity.dart';
import 'package:tokmat/domain/entities/shop_entity.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../core/utils.dart';
import '../../../domain/entities/user_entity.dart';
import 'firebase_remote_data_source.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  FirebaseRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  @override
  Future<void> signInUser(UserEntity user) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: user.email!, password: user.password!);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          {
            toast("Invalid email!");
          }
        case "user-disabled":
          {
            toast("User is disabled!");
          }
        case "user-not-found":
          {
            toast("User not found!");
          }
        case ("wrong-password"):
          {
            toast("Wrong password!");
          }
        default:
          toast("Something went wrong!");
      }
    }
  }

  @override
  Future<void> signUpUser(UserEntity user) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: user.email!, password: user.password!)
          .then((userCredential) async {
        if (userCredential.user?.uid != null) {
          createUser(user);
        } else {
          toast("Sign up failed!");
        }
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case ("invalid-email"):
          {
            toast("Invalid Email!");
          }
        case ("operation-not-allowed"):
          {
            toast("Operation not allowed!");
          }
        case ("weak-password"):
          {
            toast("The password is too weak!");
          }
        case ("email-already-in-use"):
          {
            toast("The account already exists with that email!");
          }
        default:
          toast("Something went wrong!");
      }
    }
  }

  @override
  Future<void> signOut() async => await firebaseAuth.signOut();

  @override
  Future<bool> isSignIn() async => firebaseAuth.currentUser != null;

  @override
  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;

  @override
  Future<void> createUser(UserEntity user) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    final uid = await getCurrentUid();
    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        uid: uid,
        username: user.username ?? "",
        email: user.email ?? "",
        name: user.name ?? "",
        profilePhotoUrl: user.profilePhotoUrl ?? "",
      ).toJson();

      userDoc.exists
          ? userCollection.doc(uid).update(newUser)
          : userCollection.doc(uid).set(newUser);
    }).catchError((error) {
      toast("create user error: $error");
    });
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    final uid = await getCurrentUid();
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    final userUpdate = UserModel(
      uid: uid,
      username: user.username,
      email: user.email,
      name: user.name,
      profilePhotoUrl: user.profilePhotoUrl,
    ).toJson();

    userUpdate.removeWhere((key, value) => value == null || value == '');

    await userCollection.doc(uid).update(userUpdate);
  }

  @override
  Future<UserModel> getUser() async {
    final uid = await getCurrentUid();
    final querySnapshot = await firebaseFirestore
        .collection(FirebaseConst.users)
        .where("uid", isEqualTo: uid)
        .get();
    return querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
  }

  @override
  Future<void> createShop(ShopEntity shop) async {
    final uid = await getCurrentUid();
    final shopCollection = firebaseFirestore.collection(FirebaseConst.shops);
    final newShopId = const Uuid().v1();
    final newShop = ShopModel(
      id: newShopId,
      userId: uid,
      name: shop.name,
      category: shop.category,
      phoneNumber: shop.phoneNumber,
      createdAt: Timestamp.now(),
    ).toJson();
    // shopCollection.add(newShop);

    try {
      shopCollection.doc(newShopId).set(newShop, SetOptions(merge: true));
    } catch (e) {
      print("create shop error : $e");
    }
  }

  @override
  Future<ShopEntity> getShop() async {
    final uid = await getCurrentUid();
    final shopCollection = firebaseFirestore.collection(FirebaseConst.shops);
    final data = await shopCollection.where("user_id", isEqualTo: uid).get();
    return data.docs.map((e) => ShopModel.fromSnapshot(e)).single;
  }

  @override
  Future<void> updateShop(ShopEntity shop) async {
    final shopId = (await getShop()).id;
    final shopCollection = firebaseFirestore.collection(FirebaseConst.shops);

    final shopUpdate = ShopModel(
            name: shop.name,
            category: shop.category,
            phoneNumber: shop.phoneNumber)
        .toJson();

    shopUpdate.removeWhere((key, value) => value == null || value == '');

    await shopCollection.doc(shopId).update(shopUpdate);
  }

  @override
  Future<void> createTransaction(TransactionEntity transaction) async {
    final currentShop = await getShop();
    final transactionCollection =
        firebaseFirestore.collection(FirebaseConst.transactions);
    final newTransactionId = const Uuid().v1();
    final newTransaction = TransactionModel(
      id: newTransactionId,
      shopId: currentShop.id,
      note: transaction.note,
      total: transaction.total,
      items: transaction.items,
      type: transaction.type,
      createdAt: Timestamp.now(),
    ).toJson();

    try {
      transactionCollection
          .doc(newTransactionId)
          .set(newTransaction, SetOptions(merge: true));
    } catch (e) {
      print("create transaction error : $e");
    }
  }

  @override
  Stream<List<TransactionEntity>> getTransactions() {
    final transactionCollection =
        firebaseFirestore.collection(FirebaseConst.transactions);
    final data = transactionCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((doc) => TransactionModel.fromSnapshot(doc))
            .toList());
    return data;
  }

  @override
  Future<void> createProduct(ProductEntity product) async {
    final currentShop = await getShop();
    final productCollection =
        firebaseFirestore.collection(FirebaseConst.products);
    final newProductId = const Uuid().v1();
    final newProduct = ProductModel(
      id: newProductId,
      shopId: currentShop.id,
      name: product.name,
      price: product.price,
      capital: product.capital,
      productPhotoUrl: product.productPhotoUrl,
      stock: product.stock,
      createdAt: Timestamp.now(),
    ).toJson();

    try {
      productCollection
          .doc(newProductId)
          .set(newProduct, SetOptions(merge: true));
    } catch (e) {
      print("create product error : $e");
    }
  }

  @override
  Future<void> updateProduct(ProductEntity product) async {
    final productCollection =
        firebaseFirestore.collection(FirebaseConst.products);

    final productUpdate = ProductModel(
      name: product.name,
      stock: product.stock,
      price: product.price,
      capital: product.capital,
      productPhotoUrl: product.productPhotoUrl,
    ).toJson();

    productUpdate.removeWhere((key, value) => value == null || value == '');

    await productCollection.doc(product.id).update(productUpdate);
  }

  @override
  Future<void> deleteProduct(String productId) async {
    final productCollection =
        firebaseFirestore.collection(FirebaseConst.products);
    await productCollection.doc(productId).delete();
  }

  @override
  Future<Stream<List<ProductEntity>>> getProducts() async {
    final currentShop = await getShop();
    final productCollection =
        firebaseFirestore.collection(FirebaseConst.products);
    final data = productCollection
        .where("shop_id", isEqualTo: currentShop.id)
        .get()
        .asStream();
    return data.map((querySnapshot) =>
        querySnapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList());
  }

  @override
  Future<String> uploadImageToStorage(
      File? file, String childName, bool isUserProfile) async {
    Reference ref = firebaseStorage
        .ref()
        .child(childName)
        .child(firebaseAuth.currentUser!.uid);

    if (!isUserProfile) {
      String id = Uuid().v1();
      ref = ref.child(id);
    }

    final uploadTask = ref.putFile(file!);
    final imageUrl =
        await uploadTask.then((value) => value.ref.getDownloadURL());
    print("uploadImageToStorage ImageURL $imageUrl");
    return imageUrl;
  }
}
