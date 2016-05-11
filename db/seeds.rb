# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.connection.execute("delete from sqlite_sequence where name = 'users'")
ActiveRecord::Base.connection.execute("delete from sqlite_sequence where name = 'fans'")
ActiveRecord::Base.connection.execute("delete from sqlite_sequence where name = 'fan_messages'")
ActiveRecord::Base.connection.execute("delete from sqlite_sequence where name = 'fan_message_types'")
ActiveRecord::Base.connection.execute("delete from sqlite_sequence where name = 'fan_questions'")
ActiveRecord::Base.connection.execute("delete from sqlite_sequence where name = 'fan_polls'")
ActiveRecord::Base.connection.execute("delete from sqlite_sequence where name = 'fan_poll_options'")

FanPoll.delete_all
FanPollOption.delete_all
FanMessageType.delete_all
User.delete_all
Fan.delete_all

1.upto(100) do |i|
   FanPoll.create!(question: "this is a test", owner_id: i)
end 

1.upto(100) do |k|
 1.upto(5) do |i|
   FanPollOption.create!(option: "test " + i.to_s, poll_id: k)
 end 
end

2.upto(100) do |i|
   FanMessageType.create!(message_type: 3, fan_id: i)
end

2.upto(100) do |i|
   Fan.create!(user_id: i, owner_id: 1)
end

1.upto(100) do |i|
   User.create!(username: "test" + i.to_s, password: "test" + i.to_s)
end

