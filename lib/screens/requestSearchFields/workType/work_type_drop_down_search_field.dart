// import 'dart:core';
//
// import 'package:dms_dealers/base/base_state.dart';
// import 'package:dms_dealers/screens/requestSearchFields/workType/work_type.dart';
// import 'package:dms_dealers/screens/requestSearchFields/workType/work_type_bloc.dart';
// import 'package:dms_dealers/utils/extensions/widget_extension.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:searchfield/searchfield.dart';
//
// import '../../../utils/extensions/methods.dart';
//
//
// class WorkTypeDropDownSearchField extends StatefulWidget {
//   final TextEditingController controller;
//   final dynamic Function(SearchFieldListItem<String>) onSuggestionTap;
//   const WorkTypeDropDownSearchField(
//       {super.key, required this.controller, required this.onSuggestionTap});
//
//   @override
//   State<WorkTypeDropDownSearchField> createState() => _WorkTypeDropDownSearchFieldState();
// }
//
// class _WorkTypeDropDownSearchFieldState extends State<WorkTypeDropDownSearchField> {
//   final WorkTypeBloc _workTypeBloc = WorkTypeBloc();
//
//   @override
//   void initState() {
//     // _workTypeBloc.fetchWorkType();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => WorkTypeBloc(),
//       child: BlocBuilder<WorkTypeBloc, BaseState>(
//         bloc: _workTypeBloc,
//         builder: (context, state) {
//           if (state is LoadingState) {
//             return const Center(
//               child: CupertinoActivityIndicator(),
//             );
//           }
//           if (state is SuccessState) {
//             List<WorkType> list = state.successResponse;
//             List<WorkType> filteredList =
//             list.whereIndexed((index, element) => index == 1 || index == 3).toList();
//
//             return SearchField<String>(
//               controller: widget.controller,
//               textInputAction: TextInputAction.done,
//               searchInputDecoration:  SearchInputDecoration(
//                   maintainHintHeight:30,
//                 label: Text("Work Type"),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.blue),
//                 ),
//                 border: OutlineInputBorder(),
//               ),
//               suggestions: filteredList
//                   .map(
//                     (e) => SearchFieldListItem(
//                   e.text ?? "",
//                   item: e.value,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: Text(
//                       e.text ?? "",
//                       style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.blue),
//                     ),
//                   ),
//                 ),
//               )
//                   .toList(),
//               onSuggestionTap: widget.onSuggestionTap,
//               suggestionsDecoration: SuggestionDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.grey.shade400),
//                 borderRadius: const BorderRadius.only(
//                   bottomRight: Radius.circular(8),
//                   bottomLeft: Radius.circular(8),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5), //color of shadow
//                     spreadRadius: 2, //spread radius
//                     blurRadius: 5, // blur radius
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               validator: (x) {
//                 final workTypes = state.successResponse.map((e) => e.text).toList();
//                 if (x!.isEmpty || isNotContained(workTypes, x)) {
//                   return 'Please Enter a Valid WorkType';
//                 }
//                 return null;
//               },
//             );
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }