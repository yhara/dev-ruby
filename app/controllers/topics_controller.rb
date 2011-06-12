class TopicsController < ApplicationController
  before_filter :require_login, :only => [:edit, :update]

  def edit
    @topic = Topic.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  def update
    @topic = Topic.find(params[:id])

    if @topic.update_attributes(params[:topic])
      redirect_to :back, :notice => 'Subject was successfully updated.'
    else
      render :action => "edit"
    end
  rescue ActiveRecord::RecordNotFound
    not_found
  end

end
