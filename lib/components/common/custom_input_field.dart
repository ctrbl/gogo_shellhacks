import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:gogo/components/screens/location_page.dart';

import 'package:gogo/components/models/network_utilities.dart';
import 'package:gogo/components/models/constants.dart';
import 'package:gogo/components/models/autocomplete_prediction.dart';
import 'package:gogo/components/models/place_auto_complete_response.dart';

class CustomInputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? Function(String?) validator;
  final bool suffixIcon;
  final bool? isDense;
  final bool obscureText;
  final TextEditingController controller; 
  final Function? onAutoComplete; 

  const CustomInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validator,
    this.suffixIcon = false,
    this.isDense,
    this.obscureText = false,
    this.onAutoComplete,
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscureText = true;
  List<AutocompletePrediction> placePredictions = []; 

  void placeAutocomplete(String query) async {
    Uri uri = Uri.https("maps.googleapis.com",
      'maps/api/place/autocomplte/json',
      {
        "input": query,
        "key": apiKey,
      });
    String? response = await NetworkUtility.fetchUrl(uri); 

    if (response != null) {
      PlaceAutocompleteResponse result = PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.labelText, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          ),
          TextFormField(
            onChanged: (value) {
              placeAutocomplete(value);
            },
            obscureText: (widget.obscureText && _obscureText),
            decoration: InputDecoration(
              isDense: (widget.isDense != null) ? widget.isDense : false,
              hintText: widget.hintText,
              suffixIcon: widget.suffixIcon ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.remove_red_eye : Icons.visibility_off_outlined,
                  color: Colors.black54,
                ),
                onPressed: () {
                  // widget.onAutoComplete!(placePredictions);
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ): null,
              suffixIconConstraints: (widget.isDense != null) ? const BoxConstraints(
                  maxHeight: 33
              ): null,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator,
          ),
        ],
      ),
    );
  }
}