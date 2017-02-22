class SecretsController < ApplicationController

  def index
    @checker = true
    # @user_likes = User.find(session[:user_id]).secrets.where(user_id:session[:user_id])
    @user_likes = User.find(session[:user_id]).likes
    @user = User.find(session[:user_id])
    @secrets = Secret.all
  end

  def create
    user = User.find(session[:user_id])
    Secret.create(content: params[:content],user: user)
    redirect_to ("/view/#{user.id}")
  end

  def destroy
    user = User.find(session[:user_id])
    Secret.find(params[:id]).destroy
    redirect_to ("/view/#{user.id}")
  end

  def like
    user = User.find(session[:user_id])
    secret = Secret.find(params[:id])
    Like.create(user:user, secret:secret)
    redirect_to ("/secrets/show")
  end

  def unlike
    Like.where(:secret_id => params[:id], :user_id => session[:user_id]).destroy_all
    redirect_to ("/secrets/show")
  end
end
