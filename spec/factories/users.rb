
FactoryBot.define do
  factory :user do

    gimei = Gimei.name

    email                   { Faker::Internet.free_email }
    password                { "sample5712" }
    password_confirmation   { password }
    nickname                { Faker::Name.initials(:number => 2) }
    family_name             { gimei.last.kanji }
    first_name              { gimei.first.kanji }
    katakana_family_name    { gimei.last.katakana }
    katakana_first_name     { gimei.first.katakana }
    birthday                { "1957-10-27" }
  end
end