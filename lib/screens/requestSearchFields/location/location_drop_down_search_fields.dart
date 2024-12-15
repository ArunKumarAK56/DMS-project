// import 'package:dms_dealers/base/base_state.dart';
// import 'package:dms_dealers/screens/requestSearchFields/location/location_bloc.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:searchfield/searchfield.dart';
//
//
// class LocationDropDownSearchField extends StatefulWidget {
//   final TextEditingController controller;
//   final dynamic Function(SearchFieldListItem<String>) onSuggestionTap;
//   final SearchFieldListItem<String>? initialValue;
//   final String assetId;
//
//   const LocationDropDownSearchField(
//       {super.key,
//         required this.controller,
//         required this.onSuggestionTap,
//         this.initialValue,
//         required this.assetId});
//
//   @override
//   State<LocationDropDownSearchField> createState() => _LocationDropDownSearchFieldState();
// }
//
// class _LocationDropDownSearchFieldState extends State<LocationDropDownSearchField> {
//   final LocationBloc _locationBloc = LocationBloc();
//   // final SingleAssetCubit _assetBloc = SingleAssetCubit();
//
//   @override
//   void initState() {
//     // _locationBloc.fetchLocation();
//     // _assetBloc.fetchAssetsById(widget.assetId);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => LocationBloc(),
//         ),
//         // BlocProvider(
//         //   create: (context) => SingleAssetCubit(),
//         // ),
//       ],
//       child: Column(
//         children: [
//           BlocBuilder<LocationBloc, BaseState>(
//             bloc: _locationBloc,
//             builder: (context, state) {
//               if (state is LoadingState) {
//                 return const Center(
//                   child: CupertinoActivityIndicator(),
//                 );
//               }
//               if (state is SuccessState) {
//                 return SearchField(
//                   controller: widget.controller,
//                   selectedValue: widget.initialValue,
//                   maxSuggestionBoxHeight: 100,
//                   dynamicHeight: true,
//                   searchInputDecoration:  SearchInputDecoration(
//                     labelText: "Location",
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.blue),
//                     ),
//                     border: OutlineInputBorder(),
//                   ),
//                   suggestions: state.successResponse
//                       .map(
//                         (e) => SearchFieldListItem(
//                       "${e.locationCode} - ${e.locationName?.capitalize()}",
//                       item: e.id,
//                       child: Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: Text(
//                           "${e.locationCode} - ${e.locationName?.capitalize()}",
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w500,
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                       .toList(),
//                   onSuggestionTap: widget.onSuggestionTap,
//                   suggestionsDecoration: SuggestionDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.grey.shade400),
//                     borderRadius: const BorderRadius.only(
//                       bottomRight: Radius.circular(8),
//                       bottomLeft: Radius.circular(8),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   validator: (x) {
//                     final locations = state.successResponse
//                         .map((e) => "${e.locationCode} - ${e.locationName?.capitalize()}")
//                         .toList();
//                     if (x == null || x.isEmpty || !locations.contains(x)) {
//                       return 'Please Enter a Valid Location';
//                     }
//                     return null;
//                   },
//                 );
//
//               }
//               return Container();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
