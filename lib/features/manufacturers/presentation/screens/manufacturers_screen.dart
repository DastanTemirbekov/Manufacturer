/* External dependencies */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/* Local dependencies */
import 'package:test_project/features/manufacturers/data/models/manufacturers_model.dart';
import 'package:test_project/features/manufacturers/data/repositories/manufacturers_repository_impl.dart';
import 'package:test_project/features/manufacturers/domain/use_cases/manufacturers_use_case.dart';
import 'package:test_project/features/manufacturers/presentation/logic/bloc/manufacturers_bloc.dart';
import 'package:test_project/features/manufacturers/presentation/screens/manufacturers_info_screen.dart';
import 'package:test_project/features/manufacturers/presentation/widgets/manufacturer_card.dart';
import 'package:test_project/generated/l10n.dart';
import 'package:test_project/internal/helpers/components/all_shimmers/manufacturers_shimmer.dart';
import 'package:test_project/internal/helpers/components/custom_error_widget.dart';
import 'package:test_project/internal/helpers/components/custom_spinner.dart';
import 'package:test_project/internal/helpers/components/flushbar.dart';

class ManufacturersScreen extends StatefulWidget {
  final ManufacturersBloc? blocForTest;
  final List<ManufacturersModel>? manufacturersListForTest;

  const ManufacturersScreen({
    super.key,
    this.blocForTest,
    this.manufacturersListForTest,
  });

  @override
  State<ManufacturersScreen> createState() => _ManufacturersScreenState();
}

class _ManufacturersScreenState extends State<ManufacturersScreen> {
  late ScrollController scrollController;
  late ManufacturersBloc bloc;
  int counter = 1;
  late List<ManufacturersModel> manufacturersList;
  bool isLoading = false;

  @override
  void initState() {
    manufacturersList = widget.manufacturersListForTest ?? [];

    bloc = widget.blocForTest ??
        ManufacturersBloc(
          ManufacturersUseCase(ManufacturersRepositoryImpl()),
        );

    bloc.add(GetAllManufacturersEvent(
      page: counter,
      isFirstCall: true,
    ));

    scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);

    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    scrollController.dispose();

    super.dispose();
  }

  _scrollListener() {
    if (manufacturersList.isNotEmpty) {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        isLoading = true;

        if (isLoading) {
          counter = counter + 1;

          bloc.add(GetAllManufacturersEvent(page: counter));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).manufacturersList),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          bloc.add(GetAllManufacturersEvent(
            page: counter,
            isFirstCall: true,
          ));
        },
        child: BlocConsumer<ManufacturersBloc, ManufacturersState>(
          bloc: bloc,
          listener: (context, state) {
            if (state is ManufacturersErrorState) {
              Exceptions.showFlushbar(
                state.error.message ?? '',
                context: context,
              );
            }

            if (state is ManufacturersLoadedState) {
              manufacturersList.addAll(state.manufacturersList);

              isLoading = false;
            }
          },
          builder: (context, state) {
            if (state is ManufacturersLoadingState) {
              return const ManufacturersShimmer();
            }

            if (state is ManufacturersErrorState) {
              return CustomErrorWidget(
                onTap: () {
                  bloc.add(GetAllManufacturersEvent(
                    page: counter,
                    isFirstCall: true,
                  ));
                },
              );
            }

            if (state is ManufacturersLoadedState) {
              return ListView.separated(
                key: const Key('manufactureListView'),
                controller: scrollController,
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 20.h,
                ),
                itemCount: manufacturersList.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20.h);
                },
                itemBuilder: (context, index) {
                  if (index >= manufacturersList.length - 1) {
                    return const CustomSpinner();
                  }

                  return ManufacturerCard(
                      key: Key(index.toString()),
                      id: manufacturersList[index].mfrId.toString(),
                      title: manufacturersList[index].country,
                      subTitle: manufacturersList[index].mfrName,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ManufacturerInfoScreen(
                              name: manufacturersList[index]
                                  .mfrName
                                  .split(" ")
                                  .first
                                  .replaceAll(
                                    RegExp('[^a-zA-Z]'),
                                    '',
                                  )
                                  .toLowerCase(),
                            ),
                          ),
                        );
                      });
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
