'use strict'
window.actionFields = ['matchNumber', 'teamNumber', 'type', 'duration']


angular.module('scoutingApp')
  .controller 'MainCtrl', ($scope, ParseObject, ParseQuery) ->
    action = Parse.Object.extend('Action')
    $scope.newAction = new ParseObject('Action', window.actionFields)

  .controller 'TeamCtrl', ($scope, $routeParams, ParseObject, ParseQuery, $compile) ->
    $scope.team = $routeParams.team

  .controller 'MatchCtrl', ($scope, $routeParams, ParseObject, ParseQuery, $compile) ->
    $scope.match = Parse.Object.extend('Action')
    $scope.match.team = $routeParams.team
    $scope.match.match = $routeParams.match
    $scope.match.start = {}
    $scope.actions = [
                      {name: 'Auton_Balls', values: []},
                      {name: 'Possess', values: []},
                      {name: 'Truss', values: []},
                      {name: 'Catch', values: []},
                      {name: 'Low_Goal', values: []},
                      {name: 'High_Goal', values: []}
                    ]
    $scope.save = (a, element) =>
      time = null
      time = (new Date() - $scope.match.start[element])/1000 #convert to seconds
      $("#" + element).replaceWith($("#" + element))
      $("#" + element).text($("#" + element).attr("id"))
      $("#" + element).attr("ng-click", "toggle('"+element+"')")
      $("#"+element).removeClass("btn-danger")
      $compile($("#"+element))($scope)
      $scope.actions.filter((el) -> el.name == element)[0].values.push time
      newAction = new ParseObject('Action', window.actionFields)
      newAction.teamNumber = parseInt(a.team)
      newAction.matchNumber = parseInt(a.match)
      newAction.duration = time
      newAction.type = element
      # newAction.save()
      $scope.match.start[element] = null
      null
    $scope.toggle = (element) =>
      element ||= event.currentTarget.id
      $("#"+element).replaceWith($("#"+element))
      $("#"+element).text("Timing..")
      $("#"+element).addClass("btn-danger")
      $("#"+element).attr("ng-click", "save(match, '"+element+"')")
      $compile($("#"+element))($scope)
      $scope.match.start[element] = new Date()
      null
    $scope.deleteTime = =>
      [type, index] = event.currentTarget.id.split("-")
      index = parseInt type
      actions = $scope.actions.filter((el) -> el.name == type)[0]
      actions.values.splice(index, 1)


