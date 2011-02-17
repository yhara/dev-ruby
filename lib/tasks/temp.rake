desc "fix accounts to screen_name"
task :temp => :environment do
  Account.all.each do |ac|
    info = Twitter.user(ac.uid.to_i)
    ac.name = info.screen_name
    p ac, ac.save

    u = ac.user
    if u
      u.name = ac.name
      u.profile_image_url = info.profile_image_url
      p u, u.save
    end
  end
end
