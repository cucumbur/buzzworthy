class MessagesController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	
	def create
		@user = User.find(params[:send_to_id])
    @message = @user.messages.build(message_params)
    if @message.save
      flash[:success] = "Message sent!"
      redirect_to inbox_path
    else
      render root_path
    end
  end
  
  def destroy
  end

  private

    def message_params
    	newid = current_user.id
      params.require(:message).permit(:content, :subject).merge(:from_id => newid)
    end
    
    
end
