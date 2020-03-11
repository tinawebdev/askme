class UsersController < ApplicationController
  before_action :load_user, except: [:index, :create, :new]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.sorted
    @hashtags = Hashtag.sorted
  end
  
  def new
    redirect_to root_url, alert: t('controllers.users.you_are_already_logged_in') if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: t('controllers.users.you_are_already_logged_in') if current_user.present?
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: t('controllers.users.successfully_registered')
    else
      render 'new'
    end
  end

  def edit
  end
  
  def show
    @questions = @user.questions.sorted.paginate(page: params[:page], per_page: 5)
    @new_question = @user.questions.build
    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
  end

  def update
    if @user.update(user_params)
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: t('controllers.users.updated')
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to root_url, notice: t('controllers.users.deleted')
  end

  private

  def load_user
    @user ||= User.find_by!(slug: params[:id])
  end

  def authorize_user
    reject_user unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                :name, :username, :avatar_url, :bgcolor)
  end
  
end
