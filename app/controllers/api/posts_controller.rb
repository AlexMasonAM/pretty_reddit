class Api::PostsController < ApplicationController
  # protect_from_forgery with: :null_session ((bad practice to include during production))
  def index
    posts = Post.all
    render json: posts, 
                 except: [:updated_at, :created_at], 
                 include: {
                            comments: { except: [:updated_at, :user_id, :post_id]}
                            # users:    { except: [:updated_at, :password_digest]}
                          }
  end

  def show
    post = Post.find(params[:id])
    render json: post,
                 except: [:updated_at, :created_at], 
                 include: {
                            comments: { except: [:updated_at, :user_id, :post_id]}
                            # users:    { except: [:updated_at, :password_digest]}
                          }
  end

  def create
    post = Post.new(post_params)
    if post.save
      render json: post
    else
      render json: {errors: post.errors}, status: 422
    end
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      render json: post
    else
      render json: {errors: post.errors}, status: 422
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      render json: post, status: 200
    else
      render json: post, status: 400
    end
  end

  def post_params
    params.require(:post).permit(:id, :title, :link, :user_id)
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