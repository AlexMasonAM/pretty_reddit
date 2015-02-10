class Api::PostsController < ApplicationController
  def index
    posts = Post.all
    render json: posts, 
           except: [:updated_at, :created_at], 
           include: {
                      comments: { except: [:updated_at, :user_id, :post_id]}
                      # users:    { except: [:updated_at, :password_digest]}
                    }
  end
end

# OR USE THE MODULE SYNTAX
# module Api
#   class PostsController < ApplicationController
#     def index
#       render json: {:title => "Hello"}.to_json
#     end
#   end 
# end