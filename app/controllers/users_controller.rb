class UsersController < ApplicationController
  def index
    @users = User.all
    @user = current_user
    if current_user
      if params[:food_column] && params[:food_direction]
        @foods = @user.foods.order(params[:food_column] => params[:food_direction])
      else
        @foods = @user.foods
      end
      if params[:exercise_column] && params[:exercise_direction]
        @exercises = @user.exercises.order(params[:exercise_column] => params[:exercise_direction])
      else
        @exercises = @user.exercises
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    # @user = User.new(user_params)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome"
      redirect_to '/'
    else
      flash[:alert] = 'There was a problem creating your account. Please try again.'
      redirect_to :back
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = @user.name + "Successfully updated."
      redirect_to user_path(user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = @user.name + "successfully deleted!"
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
