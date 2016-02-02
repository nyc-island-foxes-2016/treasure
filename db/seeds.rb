# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# User.delete_all && Item.delete_all && Swipe.delete_all && Match.delete_all && Messages.delete_all

nicola = User.create!(name:"Nicola", password: "password", email:"nicola@example.com")
darius = User.create!(name:"Darius", password: "password", email:"darius@example.com")
natalie = User.create!(name:"Natalie", password: "password", email:"natalie@example.com")
carolina = User.create!(name:"Carolina", password: "password", email:"carolina@example.com")
pete = User.create!(name:"Pete", password: "password", email:"pete@example.com")
sasha = User.create!(name:"Sasha", password: "password", email:"sasha@example.com")
bernadette = User.create!(name:"Bernadette", password: "password", email:"bernadette@example.com")
zach = User.create!(name:"Zach", password: "password", email:"zach@example.com")
jeff = User.create!(name:"Jeff", password: "password", email:"jeff@example.com")
chris = User.create!(name:"Chris", password: "password", email:"chris@example.com")
luis = User.create!(name:"Luis", password: "password", email:"luis@example.com")
steven = User.create!(name:"Steven", password: "password", email:"steven@example.com")

chanel = Item.create!(name:"Chanel No5", description: "perfume", user: nicola)
nexus = Item.create!(name:"Nexus 4", description: "my old phone still works!", user: darius)
chair = Item.create!(name:"Vintage Chair", description: "cool backless chair", user: natalie)
handbag = Item.create!(name:"Designer Handbag", description: "awesome", user: carolina)
piano = Item.create!(name:"Steinway piano", description: "Piano Pete's piano", user: pete)
scarf = Item.create!(name:"Pashmina scarf", description: "best scarf evaaaaa", user: sasha)
book = Item.create!(name:"Book of poetry", description: "anonymous poems", user: bernadette)
phish_album = Item.create!(name:"Vintage phish album", description: "jam on, man", user: zach)
cookies = Item.create!(name:"Girl Scout cookies", description: "great cookies", user: jeff)
headphones = Item.create!(name:"Nice headphones", description: "noise-cancelling beats", user: chris)
shirt = Item.create!(name:"Fluorescent shirt", description: "bright yellow shirt", user: luis)
computer = Item.create!(name:"Teacher's computer", description: "i love tech", user: steven)

#Matches
s1 = Swipe.create!(my_item: chanel, other_item: nexus, direction:"R")
s2 = Swipe.create!(my_item: nexus, other_item: chanel, direction:"R")
s7 = Swipe.create!(my_item: book, other_item: phish_album, direction:"R")
s8 = Swipe.create!(my_item: phish_album, other_item: book, direction:"R")
s14 = Swipe.create!(my_item: chanel, other_item: book, direction:"R")
s15 = Swipe.create!(my_item: book, other_item: chanel, direction:"R")
s18 = Swipe.create!(my_item: nexus, other_item: cookies, direction:"R")
s19 = Swipe.create!(my_item: cookies, other_item: nexus, direction:"R")

match1 = Match.create!(given_swipe: s1, received_swipe: s2)
match2 = Match.create!(given_swipe: s7, received_swipe: s8)
match3 = Match.create!(given_swipe: s14, received_swipe: s15)

#Swapped_match
match4 = Match.create!(given_swipe: s18, received_swipe: s19, swapped_at: DateTime.now)
#Make match4's items 'swapped'
# Item.find(2).update_attributes(swapped: true)
# Item.find(9).update_attributes(swapped: true)

#Opposing
s3 = Swipe.create!(my_item: chair, other_item: handbag, direction:"L")
s4 = Swipe.create!(my_item: handbag, other_item: chair, direction:"R")
s9 = Swipe.create!(my_item: cookies, other_item: headphones, direction:"R")
s10 = Swipe.create!(my_item: headphones, other_item: cookies, direction:"L")
s11 = Swipe.create!(my_item: computer, other_item: shirt, direction:"L")
s12 = Swipe.create!(my_item: shirt, other_item: computer, direction:"R")

#Both Left
s5 = Swipe.create!(my_item: piano, other_item: scarf, direction:"L")
s6 = Swipe.create!(my_item: scarf, other_item: piano, direction:"L")

#Unrequited
s13 = Swipe.create!(my_item: chanel, other_item: piano, direction:"R")
s16 = Swipe.create!(my_item: nexus, other_item: shirt, direction:"L")
s17 = Swipe.create!(my_item: nexus, other_item: headphones, direction:"L")

# Example match to be used for message seeds

n_d_match = Match.where(given_swipe_id: s1.id).where(received_swipe_id: s2.id).first

m1 = Message.create!(user: nicola, content: "Let's meet to trade", match: n_d_match)
m2 = Message.create!(user: darius, content: "Ok, where?", match: n_d_match)
m3 = Message.create!(user: nicola, content: "Let's go to Ulysses", match: n_d_match)
m4 = Message.create!(user: darius, content: "Sweet I love bars.", match: n_d_match)


