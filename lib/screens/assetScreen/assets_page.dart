import 'package:dms_dealers/base/base_state.dart';
import 'package:dms_dealers/screens/assetScreen/widgets/asset_sort_by_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../utils/color_resources.dart';
import '../../utils/search_field_bar.dart';
import '../drawer/WorkOrderPage/work_order_page.dart';
import 'asset_bloc.dart';

class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  List<CheckBoxListTileModel> checkBoxListTileModel = CheckBoxListTileModel.getUsers();

  final AssetBloc _bloc = AssetBloc();

  @override
  void initState() {
    // _bloc.fetchAssets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: BlocProvider(
            create: (context) => AssetBloc(),
            child: Scaffold(
              backgroundColor: Colors.grey.shade300,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(170),
                child: Material(
                  elevation: 2,
                  child: Container(
                    decoration: const BoxDecoration(),
                    child: Column(
                      children: [
                        AppBar(
                          title: Text(
                            'Assets',
                            style: const TextStyle(color: Colors.black),
                          ),
                          centerTitle: true,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          leading: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              if(mounted){
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ),

                        /* ------------------ 1_Search Field ------------------ */

                        const SearchFieldBar(title: "Search all Assets"),
                        const SizedBox(
                          height: 10,
                        ),
                        /* ------------------ Sort By Section ------------------ */

                        BlocBuilder<AssetBloc, BaseState>(
                          bloc: _bloc,
                          builder: (context, state) {
                            if (state is LoadingState) {
                              return const Center(
                                child: CupertinoActivityIndicator(),
                              );
                            }
                            if (state is SuccessState) {
                              return AssetSortByWidget(
                                checkBoxListTileModel: checkBoxListTileModel,
                                results: state.successResponse.length > 1
                                    ? " ${state.successResponse.length} Results"
                                    : " ${state.successResponse.length} Result",
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: BlocConsumer<AssetBloc, BaseState>(
                bloc: _bloc,
                listener: (BuildContext context, BaseState state) {
                  if (state is FailureState) {
                    SnackBar snackBar = SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                builder: (BuildContext context, state) {
                  if (state is LoadingState) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                  if (state is SuccessState) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        children: [
                          /////////////////////////// SERVICE REQUEST LISTS \\\\\\\\\\\\\\\\\\\\\\\\\\
                          Expanded(
                            child: Scrollbar(
                              child: ListView.separated(
                                itemCount: state.successResponse.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    margin: const EdgeInsets.all(4),
                                    semanticContainer: false,
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          /////////////////////////// SERVICE REQUEST TITLE \\\\\\\\\\\\\\\\\\\\\\\\\\
                                          Text(
                                            state.successResponse[index].assetName ?? "",
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),

                                          Row(
                                            children: [
                                              Icon(
                                                Icons.qr_code_2_outlined,
                                                color: Colors.grey.shade600,
                                                size: 18,
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                state.successResponse[index].assetCode ?? "AssetCode",
                                                style: TextStyle(color: Colors.grey.shade600),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                color: Colors.grey.shade600,
                                                size: 18,
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                state.successResponse[index].locationName ?? "Location",
                                                style: TextStyle(color: Colors.grey.shade600),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: Text("An error Occurred!"),
                  );
                },
              ),
            ),
          ),
        ),
    );
  }
}
