// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hiba/components/app_text_form_field.dart';
import 'package:hiba/entities/address.dart';
import 'package:hiba/entities/location.dart';
import 'package:hiba/utils/api/location.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';
import 'package:pinput/pinput.dart';

class NewAddressPage extends StatefulWidget {
  static const routeName = '/new-adress';
  const NewAddressPage({super.key});

  @override
  State<StatefulWidget> createState() => _NewAddressPage();
}

enum AddressType { other, home, work }

class _NewAddressPage extends State<NewAddressPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  City? _selectedCityId;
  List<City> _cities = [];

  AddressType _addressType = AddressType.other;

  late final TextEditingController cityController;
  late final TextEditingController addressController;
  late final TextEditingController houseController;
  late final TextEditingController apartmentController;
  late final TextEditingController entranceController;
  late final TextEditingController floorController;
  late final TextEditingController addressNameController;

  void initControllers() {
    cityController = TextEditingController()..addListener(controllerListener);
    addressController = TextEditingController()
      ..addListener(controllerListener);
    houseController = TextEditingController()..addListener(controllerListener);
    apartmentController = TextEditingController()
      ..addListener(controllerListener);
    entranceController = TextEditingController()
      ..addListener(controllerListener);
    floorController = TextEditingController()..addListener(controllerListener);
    addressNameController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    cityController.dispose();
    addressController.dispose();
    houseController.dispose();
    apartmentController.dispose();
    entranceController.dispose();
    floorController.dispose();
    addressNameController.dispose();
  }

  void controllerListener() {
    // final city = cityController.text;
    // final address = addressController.text;
    // final building = houseController.text;
    // final apartment = apartmentController.text;
    // final entrance = entranceController.text;
    // final floor = floorController.text;
    // final name = addressNameController.text;
  }

  void printFormInputs() async {
    // print(_selectedCityId);
    // print(addressController.text);
    // print(houseController.text);
    // print(apartmentController.text);
    // print(entranceController.text);
    // print(floorController.text);
    // print(addressNameController.text);
    if (_selectedCityId != null) {
      try {
        Address address = Address(
          id: 0,
          name: addressNameController.text,
          address: addressController.text,
          building: houseController.text,
          apartment: apartmentController.text,
          entrance: entranceController.text,
          floor: floorController.text,
          city: _selectedCityId!,
        );
        int status = await addAddress(address);
        if (status == 200) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop(true);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> loadCities() async {
    final data = await getCities();
    if (data != null) {
      setState(() {
        _cities = data;
        _selectedCityId = _cities[0];
      });
    }
  }

  @override
  void initState() {
    loadCities();
    initControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          'Новый адрес',
          style: AppTheme.headingBlack600_16,
        ),
        shape:
            const Border(bottom: BorderSide(width: 1, color: AppColors.grey)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _selectedCityId == null
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      DropdownButtonFormField(
                        value: _selectedCityId,
                        items: _cities.map<DropdownMenuItem<City>>((City city) {
                          return DropdownMenuItem<City>(
                            value: city,
                            child: Text(city.toString()),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: AppColors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          fillColor: AppColors.white,
                          hintStyle: AppTheme.bodyDarkgrey500_16,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        style: AppTheme.headingBlack500_16,
                        onChanged: (City? newValue) {
                          setState(() {
                            _selectedCityId = newValue!;
                          });
                        },
                      ),

                      const SizedBox(height: 8),
                      AppTextFormField(
                        controller: addressController,
                        placeholder: 'Улица/микрорайон',
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextFormField(
                              controller: houseController,
                              placeholder: 'Дом',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: AppTextFormField(
                              controller: apartmentController,
                              placeholder: 'Квартира',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Expanded(
                            child: AppTextFormField(
                              keyboardType: TextInputType.number,
                              controller: entranceController,
                              placeholder: 'Подъезд',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: AppTextFormField(
                              keyboardType: TextInputType.number,
                              controller: floorController,
                              placeholder: 'Этаж',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Radio(value: value, groupValue: groupValue, onChanged: onChanged),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  addressNameController.setText('home');
                                  _addressType = AddressType.home;
                                });
                              },
                              child: Container(
                                // onTap: () {},
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    width: 1,
                                    color: _addressType == AddressType.home
                                        ? AppColors.mainBlue
                                        : AppColors.grey,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        _addressType == AddressType.home
                                            ? 'assets/svg/address-home-outline-active.svg'
                                            : 'assets/svg/address-home-outline.svg',
                                        width: 24,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Дом',
                                        style: _addressType == AddressType.home
                                            ? AppTheme.bodyBlue500_11
                                            : AppTheme.bodyDarkgrey500_11,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  addressNameController.setText('work');
                                  _addressType = AddressType.work;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    width: 1,
                                    color: _addressType == AddressType.work
                                        ? AppColors.mainBlue
                                        : AppColors.grey,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        _addressType == AddressType.work
                                            ? 'assets/svg/address-briefcase-outline-active.svg'
                                            : 'assets/svg/address-briefcase-outline.svg',
                                        width: 24,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Работа',
                                        style: _addressType == AddressType.work
                                            ? AppTheme.bodyBlue500_11
                                            : AppTheme.bodyDarkgrey500_11,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _addressType = AddressType.other;
                                  addressNameController.setText('');
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    width: 1,
                                    color: _addressType == AddressType.other
                                        ? AppColors.mainBlue
                                        : AppColors.grey,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        _addressType == AddressType.other
                                            ? 'assets/svg/address-location-outline-active.svg'
                                            : 'assets/svg/address-location-outline.svg',
                                        width: 24,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Другое',
                                        style: _addressType == AddressType.other
                                            ? AppTheme.bodyBlue500_11
                                            : AppTheme.bodyDarkgrey500_11,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      _addressType == AddressType.other
                          ? Expanded(
                              child: AppTextFormField(
                                keyboardType: TextInputType.text,
                                controller: addressNameController,
                                placeholder: 'Название адреса',
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: TextButton(
          onPressed: () {
            printFormInputs();
          },
          style: ButtonStyle(
            backgroundColor:
                const MaterialStatePropertyAll<Color>(AppColors.mainBlue),
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            minimumSize: const MaterialStatePropertyAll(Size.fromHeight(48)),
          ),
          child: const Text(
            'Сохранить',
            style: AppTheme.headingWhite500_16,
          ),
        ),
      ),
    );
  }
}
