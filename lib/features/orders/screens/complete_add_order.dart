import 'dart:io';

import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/enums/enums.dart';
import 'package:disaoled_people/config/services/file_db_service.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/config/widgets/custom_progress.dart';
import 'package:disaoled_people/config/widgets/custom_snackbar.dart';
import 'package:disaoled_people/config/widgets/elevated_gradient_button.dart';
import 'package:disaoled_people/config/widgets/text_input.dart';
import 'package:disaoled_people/features/auth/providers/user_provider.dart';
import 'package:disaoled_people/features/orders/models/order_modle.dart';
import 'package:disaoled_people/features/orders/screens/widgets/picked_images_widget.dart';
import 'package:disaoled_people/features/orders/services/order_db_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CompleteAddOrder extends StatefulWidget {
  static const routeName = '/complete-add-order';
  const CompleteAddOrder({super.key});

  @override
  State<CompleteAddOrder> createState() => _CompleteAddOrderState();
}

class _CompleteAddOrderState extends State<CompleteAddOrder> {
  List<XFile> pickedimages = [];
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();

  _pickImage() async {
    final picker = ImagePicker();
    try {
      var picked = await picker.pickMultiImage();
      if (picked.isNotEmpty) {
        pickedimages.addAll(picked);

        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final type = ModalRoute.of(context)!.settings.arguments as OrderType;

    return Scaffold(
      body: ListView(
        children: [
          Container(
              // height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('اضافة طلب', style: Theme.of(context).textTheme.headlineLarge),
                  sizedBoxLarge,
                  InkWell(
                    onTap: () async {
                      _pickImage();
                      setState(() {});
                    },
                    child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.transparent,
                        child: Image.asset("assets/images/addpostimg.png", scale: 1.2)),
                  ),
                  if (pickedimages.isNotEmpty)
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return PickedImagesWidget(
                            url: File(pickedimages[i].path),
                            onTap: () {
                              pickedimages.removeAt(i);
                              setState(() {});
                            },
                          );
                        },
                        itemCount: pickedimages.length,
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          primaryColor,
                          secondaryColor,
                        ],
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
                          children: [
                            TextInput(
                                labelText: 'العنوان',
                                icon: 'assets/icons/location.svg',
                                controller: _addressController,
                                keyboardType: TextInputType.text),
                            sizedBoxMedium,
                            TextInput(
                                labelText: 'وصف',
                                icon: 'assets/icons/desc.svg',
                                controller: _descriptionController,
                                keyboardType: TextInputType.multiline,
                                minLines: 5,
                                maxLines: 10),
                            sizedBoxMedium,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 125, vertical: 20),
                      child: isLoading
                          ? const Center(child: CustomProgress())
                          : ElevatedGradientButton(
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                _formKey.currentState!.save();

                                setState(() {
                                  isLoading = true;
                                });
                                List<String> images = [];
                                //upload the images to firebase storage and get the urls
                                images = (await FileDbService(context).uploadeimages(pickedimages))!;

                                if (images.isEmpty) {
                                  showErrorSnackBar(context, 'حدث خطأ عند  انشاء الطلب');
                                  setState(() {
                                    isLoading = false;
                                  });
                                  return;
                                }

                                //TODO add order

                                final order = OrderModle(
                                    id: '',
                                    description: _descriptionController.text,
                                    location: _addressController.text,
                                    orderType: type,
                                    orderState: OrderState.available,
                                    ownerId: FirebaseAuth.instance.currentUser!.uid,
                                    ownerName: context.read<UserProvider>().user!.name,
                                    ownerPic: context.read<UserProvider>().user!.image,
                                    reciverId: null,
                                    images: images,
                                    deliverdTime: null);

                                await OrderDbService().addOrder(order, context);
                              },
                              text: 'اضافة')),
                ],
              )),
        ],
      ),
    );
  }
}
