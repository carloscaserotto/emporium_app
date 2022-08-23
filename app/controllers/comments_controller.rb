class CommentsController < ApplicationController
    def create
        #byebug
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create(comment_params)
        redirect_to post_path(@post)
    end

    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to @post
    end

    def show
        #byebug
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        #<%= link_to "Show Comment", [comment.post, comment] %>
        ##<ActionController::Parameters {"controller"=>"comments", "action"=>"show", "post_id"=>"1", "id"=>"17"} permitted: false>
    end


      def edit
        #byebug
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        #http://localhost:3000/posts/3/comments/3/edit
        #<%= link_to "Edit Comment", edit_post_comment_path(@comment.post), data: {confirm: "Are you sure?"} %>|  
        #<ActionController::Parameters {"controller"=>"comments", "action"=>"edit", "post_id"=>"3", "id"=>"3"} permitted: false>
      end
      def update
        #byebug
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        if @comment.update(comment: "#{params[:comment]}")
            redirect_to @post
        else
            render 'edit'
        end
      end

    private
    def comment_params
      params.require(:comment).permit(:comment)
    end
end
