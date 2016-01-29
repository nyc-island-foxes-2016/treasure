# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# User.delete_all && Item.delete_all && Swipe.delete_all && Match.delete_all

nicola = User.create!(name:"Nicola", password: "password", email:"nicola@example.com")
darius = User.create!(name:"Darius", password: "password", email:"darius@example.com")
natalie = User.create!(name:"Natalie", password: "password", email:"natalie@example.com")
carolina = User.create!(name:"Carolina", password: "password", email:"carolina@example.com")

chanel = Item.create!(name:"Chanel No5", description: "perfume", user: nicola)
nexus = Item.create!(name:"Nexus 4", description: "my old phone still works!", user: darius)
chair = Item.create!(name:"Vintage Chair", description: "cool backless chair", user: natalie)
handbag = Item.create!(name:"Designer Handbag", description: "awesome", user: carolina)

s1 = Swipe.create!(owned_item: chanel, judged_item: nexus, direction:"R")
s2 = Swipe.create!(owned_item: nexus, judged_item: chanel, direction:"R")
s3 = Swipe.create!(owned_item: chair, judged_item: handbag, direction:"L")
s4 = Swipe.create!(owned_item: handbag, judged_item: chair, direction:"R")

n_d_match = Match.where(swipe1_id: s1.id).where(swipe2_id: s2.id).first

m1 = Message.create!(user: nicola, content: "Let's meet to trade", match: n_d_match)
m2 = Message.create!(user: darius, content: "Ok, where?", match: n_d_match)
m3 = Message.create!(user: nicola, content: "Let's go to Ulysses", match: n_d_match)
m4 = Message.create!(user: darius, content: "Sweet I love bars.", match: n_d_match)


