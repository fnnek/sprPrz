class MessagesController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @micropost = current_user.messages.build(message_params)
    if @micropost.save
      flash[:success] = "Wiadomość dodana!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end

  end

  def destroy

  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
