angular.module('spaTodo.controllers').controller 'sessionCtrl', [
  '$scope'
  '$state'
  '$auth'
  ($scope, $state, $auth) ->
    $scope.$on 'auth:login-error', (ev, reason) ->
      $scope.error = reason.errors[0]
      return

    $scope.handleLoginBtnClick = ->
      $auth.submitLogin($scope.loginForm).then (resp) ->
      return

    return
]
