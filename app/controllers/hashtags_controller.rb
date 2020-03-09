class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find(params[:id])
    @questions = @hashtag.questions
  end
end
