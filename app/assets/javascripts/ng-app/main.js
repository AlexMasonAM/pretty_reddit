angular
  .module("PrettyReddit", ['ngResource'])
  .config(function($httpProvider) {
  $httpProvider.defaults.headers.common['X-CSRF-Token'] =
    $('meta[name=csrf-token]').attr('content')
  })
  .controller("postsController", postsController);

  function postsController($scope, $http, $resource) {
    
    var Post = $resource('/api/posts/:id', {id: '@id'},
      {
        'update': { method: 'patch' }
      }
    );

    // maps query to the index method
    $scope.posts = Post.query();
    
    // works the same way as rails restful SHOW
    $scope.post = Post.get({id: 1});

    new Post({
      title: 'Gardens of the Moon',
      link: 'http://en.wikipedia.org/wiki/Gardens_of_the_Moon'
    }).$save();

    Post.get({id: 1}, function(post) {
      post.title = "Funner stiff";
      post.$update();
    });

  $scope.destroyPost = function(post){
    $scope.post = Post.get({id: post.id}, function(post) {
    post.$delete();
    $scope.posts = Post.query();
    });
  }

    // $http.get('api/posts').success(
    //   function(data){
    //     $scope.posts = data;
    //   });
  }