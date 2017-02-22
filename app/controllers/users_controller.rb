class UsersController < ApplicationController

  before_action :check_status, except: [:index, :new, :log]


  def index
    if session[:user_id]
      redirect_to ("/view/#{session[:user_id]}")
    end
  end

  def new
    user = User.create(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:pw_confirm])
    if user.valid?
      session[:user_id] = user.id
      redirect_to ("/view/#{user.id}")
    else
      flash[:errors] = user.errors.full_messages.to_sentence
      redirect_to ('/')
    end
  end

  def log
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      puts user.id
      session[:user_id] = user.id
      redirect_to ("/view/#{user.id}")
    else
      flash[:log_error] = "Something was wrong with log in credentials, please try again"
      redirect_to ('/')
    end
  end

  def out
    reset_session
    redirect_to ('/')
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if params[:name].length > 0
      @user.update(name:params[:name])
    end
    if params[:email].length > 0
      @user.update(email:params[:email])
    end
    if params[:password] == params[:pw_confirm]
      @user.update(password:params[:password], password_confirmation:params[:pw_confirm])
    end

      # @user.update(name:params[:name],email:params[:email],password:params[:password],password_confirmation:params[:pw_confirm])
    redirect_to ("/view/#{@user.id}")

  end

  def view
    if session[:user_id]
      @user_likes = User.find(session[:user_id]).likes
      @user = User.find(session[:user_id])
      @secrets = Secret.where(user_id:session[:user_id])
      @all_secrets = Secret.all
    else
      redirect_to ('/')
    end
  end


  def check_status
    if !session[:user_id]
      redirect_to ('/')
    end
  end


end
