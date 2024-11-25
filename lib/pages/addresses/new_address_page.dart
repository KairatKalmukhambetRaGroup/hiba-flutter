// ignore_for_file: avoid_print
// lib/pages/addresses/addresses_library.dart
part of 'addresses_library.dart';

/// `NewAddressPage` is a stateful widget that allows user to create new address.
///
/// ### Structure:
/// - `_selectedCityId`:
/// - `_cities`:
/// - `_addressType`:
// ignore: must_be_immutable
class NewAddressPage extends StatefulWidget {
  NewAddressPage({super.key, this.editAddress});
  Address? editAddress;

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

    if (widget.editAddress != null) {
      addressController.setText(widget.editAddress!.street);
      houseController.setText(widget.editAddress!.building);
      apartmentController.setText(widget.editAddress!.apartment);
      entranceController.setText(widget.editAddress!.entrance);
      floorController.setText(widget.editAddress!.floor);
      if (widget.editAddress!.name == 'work') {
        setState(() {
          _addressType = AddressType.work;
        });
      } else if (widget.editAddress!.name == 'home') {
        setState(() {
          _addressType = AddressType.home;
        });
      }
      addressNameController.setText(widget.editAddress!.name);
      setState(() {
        _selectedCityId = widget.editAddress!.city;
      });
    }
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
          id: widget.editAddress == null ? 0 : widget.editAddress!.id,
          name: addressNameController.text,
          street: addressController.text,
          building: houseController.text,
          apartment: apartmentController.text,
          entrance: entranceController.text,
          floor: floorController.text,
          city: _selectedCityId!,
        );
        if (widget.editAddress != null) {
          int status = await editAddress(address);
          if (status == 200) {
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop(true);
          }
        } else {
          int status = await addAddress(address);
          if (status == 201) {
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop(true);
          }
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void delete() async {
    if (widget.editAddress != null) {
      try {
        await deleteAddress(widget.editAddress!.id);
        Navigator.of(context).pop(true);
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
        if (widget.editAddress != null) {
          for (City city in _cities) {
            if (city.id == widget.editAddress!.city.id) {
              _selectedCityId = city;
            }
          }
        } else {
          _selectedCityId = _cities[0];
        }
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
      appBar: CustomAppBar(
        titleText: 'Новый адрес',
        context: context,
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
                          hintStyle: AppTheme.darkGrey500_16,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        style: AppTheme.black500_16,
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
                                            ? AppTheme.blue500_11
                                            : AppTheme.darkGrey500_11,
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
                                            ? AppTheme.blue500_11
                                            : AppTheme.darkGrey500_11,
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
                                            ? AppTheme.blue500_11
                                            : AppTheme.darkGrey500_11,
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
                      if (_addressType == AddressType.other)
                        AppTextFormField(
                          keyboardType: TextInputType.text,
                          controller: addressNameController,
                          placeholder: 'Название адреса',
                        ),
                      if (widget.editAddress != null)
                        Column(
                          children: [
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: () {
                                delete();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    const WidgetStatePropertyAll<Color>(
                                        AppColors.red),
                                shape: WidgetStatePropertyAll<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                minimumSize: const WidgetStatePropertyAll(
                                    Size.fromHeight(48)),
                              ),
                              child: const Text(
                                'Удалить',
                                style: AppTheme.white500_16,
                              ),
                            ),
                          ],
                        ),
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
                const WidgetStatePropertyAll<Color>(AppColors.mainBlue),
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            minimumSize: const WidgetStatePropertyAll(Size.fromHeight(48)),
          ),
          child: const Text(
            'Сохранить',
            style: AppTheme.white500_16,
          ),
        ),
      ),
    );
  }
}
