import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../utils/color_resources.dart';
import '../serviceRequestPage/service_request_model.dart';

class PartsPage extends StatefulWidget {
  const PartsPage({super.key});

  @override
  State<PartsPage> createState() => _PartsPageState();
}

class _PartsPageState extends State<PartsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<ServiceRequest> filteredServiceReq = [];
  List<ServiceRequest> serviceReq = [];

  void _searchSearvice(
      String enteredKeyword, List<ServiceRequest>? serviceReq) {
    List<ServiceRequest>? results = [];
    if (enteredKeyword.isEmpty) {
      setState(() {
        filteredServiceReq = serviceReq!;
      });
    } else {
      results = serviceReq
          ?.where(
            (element) => element.serviceRequestName!
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase()),
      )
          .toList();
      setState(() {
        filteredServiceReq = results!;
      });
    }
  }


  void _clearSearch() {
    _searchController.clear(); // Clear the text field
    _searchSearvice('', serviceReq); // Refresh the list with all work orders
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(170),
        child: SafeArea(
          child: Material(
            elevation: 2,
            child: Container(
              decoration: const BoxDecoration(),
              child: Column(
                children: [
                  AppBar(
                    title: const Text(
                      'Parts Inventory',
                      style: TextStyle(color: Colors.black),
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

                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: TextField(
                      controller: _searchController,
                      // onChanged: (value) => _searchSearvice(value, serviceReq),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          isDense: true,
                          // Added this
                          contentPadding: const EdgeInsets.all(8),
                          hintText: "Search all parts",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          suffixIcon: _searchController.text.isNotEmpty // Check controller text
                              ? IconButton(
                            icon: const Icon(Icons.cancel),
                            onPressed: _clearSearch,
                            color: Colors.grey.shade400,
                          )
                              : null,
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 30,
                          ),
                          prefixIconColor: Colors.grey.shade400),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  /* ------------------ Sort By Section ------------------ */

                  // BlocBuilder<AssetBloc, AssetsState>(
                  //   bloc: _bloc,
                  //   builder: (context, state) {
                  //     if (state is AssetsLoadingState) {
                  //       return const Center(
                  //         child: CupertinoActivityIndicator(),
                  //       );
                  //     }
                  //     if (state is AssetsLoadedState) {
                  //       return AssetSortByWidget(
                  //         checkBoxListTileModel: checkBoxListTileModel,
                  //         results: state.assets.length > 1
                  //             ? " ${state.assets.length} Results"
                  //             : " ${state.assets.length} Result",
                  //       );
                  //     }
                  //     return Container();
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: const Center(
        child: Text("Parts Inventory"),
      ),
    );
  }
}
