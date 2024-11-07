// lib/providers/providers_library.dart
/// @category Provider
part of 'providers_library.dart';

/// A state management class for handling addresses in the application.
///
/// `AddressState` uses [ChangeNotifier] to manage and update the current address
/// and a list of addresses. It also leverages secure storage to persist
/// address data across app sessions.
///
/// Example usage:
/// ```dart
/// AddressState addressState = AddressState();
/// await addressState.getAddresses(); // Load addresses from storage
/// addressState.setCurrentAddressById(1); // Set current address by ID
/// ```

class AddressState extends ChangeNotifier {
  /// Secure storage for persisting addresses and the current address.
  static const storage = FlutterSecureStorage();

  /// The currently selected address.
  Address? _currentAddress;

  /// Getter for the current address.
  Address? get currentAddress => _currentAddress;

  /// The list of all addresses.
  List<Address> _addresses = [];

  /// Getter for the list of all addresses.
  List<Address> get addresses => _addresses;

  /// Sets the current address by its [id].
  ///
  /// Finds the address in [_addresses] that matches the given [id] and
  /// updates [_currentAddress] to that address. Notifies listeners after updating.
  void setCurrentAddressById(int id) {
    _currentAddress = _addresses.firstWhere((element) => element.id == id);
    notifyListeners();
  }

  /// Sets the current address to a given [address].
  ///
  /// Directly updates [_currentAddress] and notifies listeners.
  void setCurrentAddress(Address address) {
    _currentAddress = address;
    notifyListeners();
  }

  /// Sets the list of addresses and updates the current address if needed.
  ///
  /// If the [data] list is empty or the current address is no longer valid,
  /// it updates [_currentAddress] to the first item in the list.
  void setAddresses(List<Address> data) {
    _addresses = data;
    if (_currentAddress == null ||
        data.indexWhere((element) => element.id == _currentAddress!.id) == -1) {
      _currentAddress = _addresses[0];
    }
  }

  /// Adds a new address to the list.
  ///
  /// This method is currently not implemented but is intended to handle
  /// adding a new address to [_addresses] and updating secure storage.
  Future<void> addAddress() async {}

  /// Retrieves the current address from secure storage.
  ///
  /// If [_currentAddress] is already set, it returns it immediately.
  /// Otherwise, it loads the address data from secure storage and decodes it,
  /// then notifies listeners after updating [_currentAddress].
  Future<Address?> getCurrentAddress() async {
    if (_currentAddress != null) return _currentAddress;

    String? currentAddressString = await storage.read(key: 'currentAddress');
    if (currentAddressString == null) return null;

    Map<String, dynamic> data = json.decode(currentAddressString);
    _currentAddress = Address.fromJson(data);
    notifyListeners();
    return _currentAddress;
  }

  /// Retrieves the list of addresses from secure storage.
  ///
  /// If [_addresses] is already populated, it returns the list.
  /// Otherwise, it loads address data from secure storage and decodes it into
  /// a list of [Address] objects, then notifies listeners.
  Future<List<Address>?> getAddresses() async {
    if (_addresses.isNotEmpty) return _addresses;

    String? addressesString = await storage.read(key: 'addresses');
    if (addressesString == null) return null;

    List<Map<String, dynamic>> data = json.decode(addressesString);
    List<Address> list = List.empty(growable: true);
    for (var el in data) {
      list.add(Address.fromJson(el));
    }
    _addresses = list;
    notifyListeners();
    return _addresses;
  }
}
