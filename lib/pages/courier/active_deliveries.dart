import 'package:flutter/material.dart';
import 'package:hiba/components/custom_scaffold.dart';
import 'package:hiba/values/app_colors.dart';
import 'package:hiba/values/app_theme.dart';

class ActiveDeliveries extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ActiveDeliveriesState();
}

class _ActiveDeliveriesState extends State<ActiveDeliveries> {
  bool _groupByButchery = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        title: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.mainBlue, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _groupByButchery = false;
                    });
                  },
                  child: Container(
                    color:
                        _groupByButchery ? AppColors.white : AppColors.mainBlue,
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      "Все заявки",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          color: _groupByButchery
                              ? AppColors.mainBlue
                              : AppColors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _groupByButchery = true;
                    });
                  },
                  child: Container(
                    color:
                        _groupByButchery ? AppColors.mainBlue : AppColors.white,
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      "По скотобойням",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          color: _groupByButchery
                              ? AppColors.white
                              : AppColors.mainBlue,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        shape:
            const Border(bottom: BorderSide(width: 1, color: AppColors.grey)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
