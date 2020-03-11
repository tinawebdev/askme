class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by!(slug: params[:id])
    @questions = @hashtag.questions.sorted
  end
end
