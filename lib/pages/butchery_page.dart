import 'package:flutter/material.dart';
import 'package:hiba/entities/butchery.dart';
import 'package:hiba/utils/api/butchery.dart';

class ButcheryPage extends StatefulWidget {
  static const routeName = '/butchery';

  const ButcheryPage({super.key, this.id});
  final String? id;

  @override
  State<StatefulWidget> createState() => _ButcherPageState();
}

class _ButcherPageState extends State<ButcheryPage> {
  bool isLoading = true;
  bool hasError = false;
  String title = '';
  late String errorMessage = '';

  late Butchery? butchery;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (widget.id == null) throw Error();
      butchery = await getButcheryById(widget.id);
      if (butchery == null) throw Error();
      setState(() {
        title = butchery!.name;
      });
    } catch (e) {
      errorMessage = 'error';
      hasError = true;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError
              ? Center(
                  child: Text(errorMessage),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'https://picsum.photos/250?image=9',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                butchery!.name,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                butchery!.address,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
    );
  }
}
