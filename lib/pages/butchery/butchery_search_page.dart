part of 'butchery_library.dart';

/// A page for searching and browsing butcheries.
///
/// The [ButcherySearchPage] displays a list of butcheries retrieved from a data source.
/// It supports filtering by categories and differentiates between charity and personal shopping modes.
///
/// ### Example Usage
/// ```dart
/// ButcherySearchPage(
///   charity: true,
/// );
/// ```
class ButcherySearchPage extends StatefulWidget {
  /// Indicates whether the search is for charity-related orders.
  final bool charity;

  /// Creates a [ButcherySearchPage].
  ///
  /// - [charity]: If `true`, the page is used for charity-related searches.
  const ButcherySearchPage({super.key, required this.charity});

  @override
  State<StatefulWidget> createState() => _ButcherySearchPageState();
}

/// The state implementation for [ButcherySearchPage].
///
/// Responsible for fetching butcheries, handling user interactions,
/// and managing the display of the list.
class _ButcherySearchPageState extends State<ButcherySearchPage> {
  /// List of butcheries retrieved from the data source.
  List<Map<String, dynamic>> _butcheries = [];

  /// Indicates whether the search is for charity-related orders.
  bool isCharity = false;

  @override
  void initState() {
    super.initState();
    loadJsonData();
    setState(() {
      isCharity = widget.charity;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Fetches the list of butcheries from the data source.
  ///
  /// Populates the [_butcheries] list with the retrieved data.
  Future<void> loadJsonData() async {
    final data = await getButcheries();
    if (data != null) {
      setState(() {
        _butcheries = data;
      });
    }
  }

  final List<String> categories = List<String>.from(['Говядина']);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: AppColors.bgLight,
      appBar: CustomAppBar(
        titleText: isCharity ? 'На благотворительность' : 'Для себя и близких',
        context: context,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 8.0),
        child: _butcheries.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemBuilder: (context, index) {
                  final butchery = ButcherySmall.fromJson(_butcheries[index]);
                  return ButcheryTile(
                    butchery: butchery,
                    isCharity: isCharity,
                  );
                },
                itemCount: _butcheries.length,
                separatorBuilder: (context, index) =>
                    const Divider(height: 1, color: AppColors.grey),
              ),
      ),
    );
  }
}
