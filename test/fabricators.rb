Fabricator(:mail) do
  number Fabricate.sequence(:number, 40000)
  subject "Test Mail"
  from "a@b.cd"
  time { Time.now }
  in_reply_to nil
  body "Test Mail."
end
