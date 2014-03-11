'use strict'

angular.module('scoutingApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'ParseServices'
])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/match/:match/:team',
        templateUrl: 'views/match.html'
        controller: 'MatchCtrl'
      .when '/team/:team',
        templateUrl: 'views/team.html'
        controller: 'TeamCtrl'
      .otherwise
        redirectTo: '/'
  .run(['ParseSDK', (ParseServices)->
    #Parse Through SI
    ])
