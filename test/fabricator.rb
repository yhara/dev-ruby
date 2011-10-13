Fabricator(:post) do
  number { Fabricate.sequence(:post_number, 40000) }
  subject "Test Mail"
  from "a@b.cd"
  time { Time.now }
  parent nil
  body "Test Mail."
end

Fabricator(:account) do
  provider "twitter"
  uid { Fabricate.sequence(:account_uid, 1000000) }
  name { "account#{Fabricate.sequence(:account_name, 1)}" }
end

Fabricator(:translation) do
  post!
  body { "hellohello" }
  user!
end

Fabricator(:user) do
  name { "user#{Fabricate.sequence(:user, 1)}" }
  profile_image_url { "http://example.jp/a.png" }
end

