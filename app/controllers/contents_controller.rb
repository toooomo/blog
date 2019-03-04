class ContentsController < ApplicationController

  before_action :move_to_index, except: :index

  def index
    @contents = Content.includes(:user).order("created_at DESC")
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.create(text: content_params[:text], user_id: current_user.id)
  end

  def destroy
    content = Content.find(params[:id])
    content.destroy if content.user_id == current_user.id
  end

  def edit
    @content = Content.find(params[:id])
  end

  def update
    content = Content.find(params[:id])
    if content.user_id == current_user.id
      content.update(content_params)
    end
  end

  def show
    @content = Content.offset( rand(Content.count) ).first
  end

    private
    def content_params
      params.require(:content).permit(:text)
    end

    def move_to_index
      redirect_to action: :index unless user_signed_in?
    end


end
