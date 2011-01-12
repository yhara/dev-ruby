class TranslationsController < ApplicationController

  # GET /translations/new
  def new
    @mail = Mail.find(params[:mail_id])
    @translation = Translation.new

    @last_subject = @mail.translation.try(:subject) || @mail.subject
    @last_body = @mail.translation.try(:body) || @mail.body

    respond_to do |format|
      format.html # new.html.erb
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to "/404.html"
  end

  # POST /translations
  def create
    @translation = Translation.new(params[:translation])
    @translation.mail = Mail.find(params[:mail_id])

    respond_to do |format|
      if @translation.save
        format.html { redirect_to(@translation.mail, :notice => 'Translation was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to "/404.html"
  end
end
