part of 'butchery_library.dart';

class ButcherySearchPage extends StatefulWidget {
  const ButcherySearchPage({super.key, required this.charity});
  final bool charity;

  @override
  State<StatefulWidget> createState() => _ButcherySearchPageState();
}

class _ButcherySearchPageState extends State<ButcherySearchPage> {
  List<Map<String, dynamic>> _butcheries = [];
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

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, required this.name, required this.route});
  final String name;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppColors.white,
      title: Text(
        name,
        style: AppTheme.black500_14,
      ),
      trailing: SvgPicture.asset(
        'assets/svg/chevron-right-grey.svg',
        width: 24,
      ),
    );
  }
}

class ButcheryTile extends StatelessWidget {
  const ButcheryTile(
      {super.key, required this.butchery, required this.isCharity});
  final ButcherySmall butchery;
  final bool isCharity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppColors.white,
      title: Text(
        butchery.name,
        style: AppTheme.black500_14,
      ),
      // subtitle: Text(
      //   butchery.categories.join(', '),
      //   style: AppTheme.darkGrey500_11,
      // ),
      trailing: SvgPicture.asset(
        'assets/svg/chevron-right-grey.svg',
        width: 24,
      ),
      onTap: () => {
        // print(isCharity)
        pushWithoutNavBar(
            context,
            MaterialPageRoute(
                builder: (context) => ButcheryPage(
                    id: butchery.id.toString(), charity: isCharity)))
      },
    );
  }
}
