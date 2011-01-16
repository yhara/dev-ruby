Fabricator(:post) do
  number { Fabricate.sequence(:number, 40000) }
  subject "Test Mail"
  from "a@b.cd"
  time { Time.now }
  parent nil
  body "Test Mail."
end
