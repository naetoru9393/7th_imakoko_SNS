class CommentsController < ApplicationController
  before_action :authenticate_user!
  
    def index
      
      @posts = current_user.posts
  
     
      @comments = current_user.comments
      

      @activities = (@posts + @comments).sort_by(&:created_at).reverse
    end

    def new
      @comment = Comment.new
    end


    def create
      @comment = current_user.comments.new(comment_params)
      @comment.post_id = params[:comment][:post_id]
      

      if @comment.save
        redirect_to post_path(@comment.post_id), notice: 'コメントが作成されました。'
      else
        Rails.logger.error(@comment.errors.full_messages.join(', '))
        redirect_to post_path(@comment.post_id), notice: 'コメントの作成に失敗しました。'
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:body)
    end


  end