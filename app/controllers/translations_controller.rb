class TranslationsController < ApplicationController
  before_filter :find_post, :only => [:index, :new, :create]
  before_filter :require_login, :only => [:new, :create]

  def index
    @translations = @post.translations.order("created_at")
    case @translations.size
    when 0
      # assign nothing
    when 1
      @translation = @translations.first
    else
      @diffs = @translations.each_cons(2).map{|tr_a, tr_b|
        [tr_a, tr_b, tr_b.diff_from(tr_a)]
      }
    end
  end

  def new
    @translation = Translation.new
  end

  def create
    @translation = Translation.new(params[:translation])
    @translation.post = @post
    @translation.user = current_user

    if @translation.save
      redirect_to(@translation.post, :notice => 'Translation was successfully created.')
    else
      render :action => "new"
    end
  end
end
