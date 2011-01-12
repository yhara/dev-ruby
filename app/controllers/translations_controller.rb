class TranslationsController < ApplicationController
#  # GET /translations
#  def index
#    @translations = Translation.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#    end
#  end
#
#  # GET /translations/1
#  def show
#    @translation = Translation.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#    end
#  end

  # GET /translations/new
  def new
    @mail = Mail.find_by_number(params[:mail_id])
    @translation = Translation.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /translations
  def create
    @translation = Translation.new(params[:translation])

    respond_to do |format|
      if @translation.save
        format.html { redirect_to(@translation.number, :notice => 'Translation was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
end
