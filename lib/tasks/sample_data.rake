namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_posts
  end
end

def make_users
  99.times do |n|
    name  = Faker::Name.name
    username  = Faker::Internet.user_name
    email = "example-#{n+1}@benfeitor.com"
    User.create!(name: name, email: email, username: username)
  end
end

def make_posts
  User.all(:limit => 10).each do |user|
    50.times do
      title  = Faker::Lorem.sentence(3)
      content = Faker::Lorem.sentence(50)
      user.posts.create!(title: title, content: content)
    end
  end
end