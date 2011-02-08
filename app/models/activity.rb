class Activity
  include Enumerable

  def initialize(user)
    @user = user
  end

  def events(n)
    events = translated(n) + translated_by_others(n) + requested(n) 
    events.sort_by{|e|
      - e.created_at.to_i
    }.first(n)
  end

  private

  def translated(n)
    Translation.includes(:post).
      where(user_id: @user.id).
      order(:created_at).
      limit(n).to_a
  end

  def translated_by_others(n)
    Translation.includes(:post).
      where("post_id IN (?) AND user_id <> ?",
            translated(n).map{|tr| tr.post.id},
            @user.id).
      order(:created_at).
      limit(n).to_a
  end

  def requested(n)
    TranslationRequest.includes(:post).
      where(user_id: @user.id).
      order(:created_at).
      limit(n).to_a
  end
end
