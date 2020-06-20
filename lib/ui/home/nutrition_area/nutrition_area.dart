import 'package:auto_size_text/auto_size_text.dart';
import 'package:bfit_tracker/blocs/nutrition_data/nutrition_data_bloc.dart';
import 'package:bfit_tracker/enums/nutrients.dart';
import 'package:bfit_tracker/models/nutrient_stat.dart';
import 'package:bfit_tracker/theme.dart';
import 'package:bfit_tracker/ui/coval_solutions/empty_app_bar.dart';
import 'package:bfit_tracker/ui/coval_solutions/no_glow_listview.dart';
import 'package:bfit_tracker/ui/home/nutrition_area/nutrient_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NutritionArea extends StatefulWidget {
  final List<NutrientsEnum> nutrientsEnums = NutrientsEnum.values;
  final List<Color> colors = [
    mainTheme.primaryColor,
    mainTheme.accentColor,
  ];

  NutritionArea({Key key}) : super(key: key);

  @override
  _NutritionAreaState createState() => _NutritionAreaState();
}

class _NutritionAreaState extends State<NutritionArea> {
  // ignore: close_sinks
  NutritionDataBloc nutritionDataBloc;
  List<NutrientStat> nutritionData;

  void getNutritionData(Future future) {
    future.then((value) {
      setState(() {
        nutritionData = value;
      });
    });
  }

  Future<void> _refresh() {
    if (nutritionData != null) {
      nutritionDataBloc.add(LoadNutritionData());
    }

    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.camera_alt),
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: this._refresh,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: AutoSizeText(
                  'Nutrition Tracker',
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CustomColor.DIM_GRAY,
                  ),
                  minFontSize: 26,
                  maxFontSize: 26,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: AutoSizeText(
                  'Weekly',
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: CustomColor.DIM_GRAY,
                    fontStyle: FontStyle.italic,
                  ),
                  minFontSize: 18,
                  maxFontSize: 18,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
              ),
              BlocConsumer<NutritionDataBloc, NutritionDataState>(
                  listener: (context, state) {
                if (this.nutritionDataBloc == null) {
                  this.setState(() {
                    nutritionDataBloc = context.bloc();
                  });
                }

                if (state is NutritionDataLoaded) {
                  this.getNutritionData(state.props.first);
                }
              }, builder: (BuildContext context, NutritionDataState state) {
                if (!(state is NutritionDataLoaded) ||
                    this.nutritionData == null) {
                  if (this.nutritionData == null && state.props.isNotEmpty) {
                    this.getNutritionData(state.props.first);
                  }

                  return Center(child: CircularProgressIndicator());
                }

                return Flexible(
                  child: ScrollConfiguration(
                    behavior: NoGlowingOverscrollIndicator(),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: nutritionData.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return NutrientCard(
                            nutrientsEnum: nutritionData[index].type,
                            value: double.parse(nutritionData[index].value),
                            color:
                                widget.colors[(index % widget.colors.length)]);
                      },
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
