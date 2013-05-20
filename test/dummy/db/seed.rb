p "Seeding ...."

User.create!(email: 'ashraf@gmail.com')
User.create!(email: 'zahid@gmail.com')
User.create!(email: 'rumjhum@gmail.com')
User.create!(email: 'himika@gmail.com')
User.create!(email: 'bzaman@gmail.com')
User.create!(email: 'mamataz@gmail.com')

def rand_user
  User.all[Random.rand(6)]
end

1.upto(100) do
  subject = LoremIpsum.lorem_ipsum(words: 20)
  body = LoremIpsum.lorem_ipsum(paragraphs: 1)
  t = Discussion::Thread.new(subject: subject)
  t.initiator = rand_user

  1.upto(3) do
    c= t.comments.build(body: body)
    c.author = rand_user
    p c.author.inspect
  end

  t.concerns.build(user_id: rand_user.id)
  t.save!
end