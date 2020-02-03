class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Kristina',
        username: 'kgoncharova',
        avatar_url: 'http://avatarmaker.ru/img/11/1044/104338.gif'
      ),
      User.new(id: 2, name: 'Misha', username: 'aristofun')
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Kristina',
      username: 'kgoncharova',
      avatar_url: 'http://avatarmaker.ru/img/11/1044/104338.gif'
    )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016'))
    ]

    @new_question = Question.new
  end
end
