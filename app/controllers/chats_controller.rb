class ChatsController < ApplicationController

  before_action :authenticate_user!


  def index
    my_rooms = current_user.user_rooms.select(:room_id)
    @rooms = UserRoom.includes(:chats).where(room_id: my_rooms).where.not(user_id: current_user.id)
  end

  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    if user_rooms.nil?
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    else
      @room = user_rooms.room
    end

    @chats = @room.chats.page(params[:page]).reverse_order
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    @chats = @chat.room.chats.page(params[:page]).reverse_order
    visited_id = @chat.room.user_rooms.where.not(user_id: current_user.id).first.user_id
    # ここから
    @chat.create_notification_chat!(current_user, @chat.id, @chat.room.id, visited_id)
    # ここまで

  end



  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

end
