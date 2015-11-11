var app = angular.module('TravelApp', ['ngMap']);


var locations = [];
var markers = [];
var destName;
var destLat;
var destLng;
app.controller('mapController', function ($scope) {
  $scope.placeChanged = function () {
    $scope.place = this.getPlace();
    var dest = $scope.place.geometry.location
    $scope.markers.push(new google.maps.Marker({
        map: $scope.map,
        position: dest,
        animation: "DROP"
      })
    );
    destLat = $scope.place.geometry.location.lat();
    destLng = $scope.place.geometry.location.lng();
    destName = $scope.place.name;
    console.log(destLat);
    console.log(destLng);
    console.log($scope.place.name);
    // console.log($scope.markers);
    locations.push({lat: dest.lat(), lng: dest.lng()})

    $scope.map.panTo({lat: dest.lat(), lng: (dest.lng() + 3.5)})
    $scope.map.setZoom(7)
  }

  $scope.show = function() {
    if (this.getAnimation() != null) {
      this.setAnimation(null);
    } else {
      this.setAnimation(google.maps.Animation.BOUNCE);
    }
    $scope.place = this.getPlace();
    var dest = $scope.place.geometry.location
    $scope.map.panTo({lat: dest.lat(),
                      lng: dest.lat()})
  }

})

//Header Controller
app.controller('HeaderController', ['$http', function($http) {
  var controller = this;
  //Get current user from route
  $http.get('/session').success(function(data) {
    //setting curent user to data.current user because data comes nested in current user
    controller.current_user = data.current_user;
    console.log(controller.current_user);
  });
}]);
var trips;
//Trips Controller
app.controller('TripsController', ['$http', '$scope', function($http, $scope) {
  //get authenticity_token from DOM (rails injects it on load)
  var authenticity_token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  var controller = this;

  //trip types for select in html
  this.TRIPTYPE = ['Summer', 'Winter', 'Family', 'Honeymoon', 'Other'];
  this.newTripTripType = "Other";

  this.getTrips = function() {
    // get trips for current User
    $http.get('/trips').success(function(data) {
      //add trips to controller, data comes back with user
      controller.current_user_trips = data.trips;
      var trips = data.trips;
      console.log(trips);
      console.log($scope);
      console.log(controller.current_user_trips);
    });
  }
  this.getTrips();

  // create a Trip
  this.createTrip = function() {

    controller.current_user_trips.push({
      title: this.newTripTitle + "...loading",
      destination: this.newTripDestination + "...loading",
      description: this.newTripDescription + "...loading",
      start_date: this.newTripStartDate + "...loading",
      end_date: this.newTripEndDate + "...loading",
      trip_type: this.newTripTripType + "...loading",
      notes: this.newTripNotes + "...loading"
    });

    $http.post('/trips', {
      authenticity_token: authenticity_token,
      trip: {
          title: this.newTripTitle,
          destination: destName,
          description: this.newTripDescription,
          longitude: destLng,
          latitude: destLat,
          start_date: this.newTripStartDate,
          end_date: this.newTripEndDate,
          trip_type: this.newTripTripType,
          notes: this.newTripNotes
      }
    }).success(function(data){
      controller.current_user_trips.pop();
      controller.current_user_trips.push(data.trip);
      controller.getTrips();
      console.log(destLat);
      console.log(destLng);
    }).error(function(error){
      console.log(error);
      console.log(destLat);
      console.log(destLng);
    });
  }
}]);


app.controller('CommentsController', ['$http', '$scope', function($http, $scope) {
  //get authenticity_token from DOM (rails injects it on load)
  var authenticity_token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  //create a comment
  this.createComment = function() {
    $http.post('/trips/'+$scope.$parent.trip.id+'/comments', {
      //include authenticity_token
      authenticity_token: authenticity_token,
      comment: {
        // trip_id: trip_id,
        entry: this.newCommentEntry
      }
    }).success(function(data) {
      $scope.$parent.trips.getTrips();
    });
  }
}]);
