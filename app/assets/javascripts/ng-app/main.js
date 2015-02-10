angular
  .module("PrettyReddit", [])
  .controller("postsController", postsController);

  function postsController($scope, $http) {
    $http.get('api/posts').success(
      function(data){
        $scope.posts = data;
      });
  }