import 'package:flutter/material.dart';
import 'package:ridepool/Helper/PlaceApiProvider.dart';
import 'package:ridepool/Helper/Suggestion.dart';

class AddressSearch extends SearchDelegate<Suggestion> {

  final sessionToken;
  PlaceApiProvider apiClient;

  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    try{
    return FutureBuilder(
      // We will put the api call here
      future: query==""
          ? null : apiClient.fetchSuggestions(
          query, Localizations.localeOf(context).languageCode
      ),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Enter your address'),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    // we will display the data returned from our future here
                    title: Text((snapshot.data[index] as Suggestion).desc),
                    onTap: () {
                      close(context, snapshot.data[index] as Suggestion);
                    },
                  ),
                  itemCount: snapshot.data.length,
                )
              : Container(child: Text('Loading.. Wait...')),

    );
    }
    catch(e){print('error in addressSearch class');}
  }

}
