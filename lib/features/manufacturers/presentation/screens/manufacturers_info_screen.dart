/* External dependencies */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_project/features/manufacturers/data/models/manufacturer_info_model.dart';

/* Local dependencies */
import 'package:test_project/features/manufacturers/data/repositories/manufacturers_repository_impl.dart';
import 'package:test_project/features/manufacturers/domain/use_cases/manufacturers_use_case.dart';
import 'package:test_project/features/manufacturers/presentation/logic/bloc/manufacturers_bloc.dart';
import 'package:test_project/features/manufacturers/presentation/widgets/manufacturer_info_card.dart';
import 'package:test_project/generated/l10n.dart';
import 'package:test_project/internal/helpers/components/all_shimmers/manufacturer_info_shimmer.dart';
import 'package:test_project/internal/helpers/components/custom_error_widget.dart';
import 'package:test_project/internal/helpers/components/flushbar.dart';

class ManufacturerInfoScreen extends StatefulWidget {
  final String name;
  final ManufacturersBloc? blocForTest;
  final List<ManufacturerInfoModel>? manufacturersListForTest;

  const ManufacturerInfoScreen({
    super.key,
    required this.name,
    this.blocForTest,
    this.manufacturersListForTest,
  });

  @override
  State<ManufacturerInfoScreen> createState() => _ManufacturerInfoScreenState();
}

class _ManufacturerInfoScreenState extends State<ManufacturerInfoScreen> {
  late ManufacturersBloc bloc;
  late List<ManufacturerInfoModel> manufacturersList;

  @override
  void initState() {
    manufacturersList = widget.manufacturersListForTest ?? [];

    bloc = widget.blocForTest ??
        ManufacturersBloc(
          ManufacturersUseCase(ManufacturersRepositoryImpl()),
        );

    bloc.add(GetManufacturerInfoEvent(name: widget.name));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          key: const Key('arrowBack'),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(S.of(context).manufacturerDetailScreen),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          bloc.add(GetManufacturerInfoEvent(name: widget.name));
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

            if (state is ManufacturerInfoLoadedState) {
              manufacturersList = state.manufacturerInfoModel;
            }
          },
          builder: (context, state) {
            if (state is ManufacturersLoadingState) {
              return const ManufacturerInfoShimmer();
            }

            if (state is ManufacturersErrorState) {
              return CustomErrorWidget(
                onTap: () {
                  bloc.add(GetManufacturerInfoEvent(name: widget.name));
                },
              );
            }

            if (state is ManufacturerInfoLoadedState) {
              return ListView.separated(
                key: const Key('manufactureInfoListView'),
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 20.h,
                ),
                itemCount: manufacturersList.length,
                separatorBuilder: (context, index) => SizedBox(height: 20.h),
                itemBuilder: (context, index) => ManufacturerInfoCard(
                    name: manufacturersList[index].modelName ?? ''),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
