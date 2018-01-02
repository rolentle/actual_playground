Faker::Config.random = Random.new(42)
prng1 = Random.new(1234)

me = {
  first_name: "Rolen",
  last_name: "Le"
}

User.create(first_name: "Rolen", last_name: "Le", email: "rolentle@gmail.com",
            password: "password",
            password_confirmation: "password",
           ).tap do |user|
  user.confirmed_at = Time.now.utc
  user.save
end

20.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: "password",
    password_confirmation: "password",
    email: Faker::Internet.unique.safe_email
  ).tap do |user|
    user.confirmed_at = Time.now.utc
    user.save
  end
end

def random_scores(number_of_reviews,random_generator)
  (1..number_of_reviews).to_a.map { |n| random_generator.rand(1..5) }
end

show_attributes = [
  {
    title: "The Adventure Zone",
    description: "Justin, Travis and Griffin McElroy from My Brother, My Brother and Me have recruited their dad Clint for a campaign of high adventure. Join the McElroys as they find their fortune and slay an unconscionable number of ... you know, kobolds or whatever in ... The Adventure Zone.",
    scores: random_scores(20, prng1)
  },
  {
    title: "Friends at the Table",
    description: "Friends at the Table is an actual play podcast about critical worldbuilding, smart characterization, and fun interaction between good friends. Find us (and a listener guide) @Friends_Table on Twitter.",
    scores: random_scores(15, prng1)
  },
  {
    title: "Spout Lore",
    description: "A series of comedy bits, loosely connected by dice rolls. Join a well-meaning barbarian, a mysterious druid, and an orphaned halfling child as they try to figure out the world they're in.",
    scores: random_scores(7, prng1)
  },
  {
    title: "Party of One Podcast",
    description: "An RPG Podcast where the gaming table is set for two. GM Jeff Stormer sits down with friends and guests to play tabletop RPGs one-on-one to see what happens when adventurers leave the party behind and strike out on their own.",
    scores: []
  }
]
shows = show_attributes.map do |show|
  s = Show.create(title: show[:title], description: show[:description])
  users = User.order("RANDOM()").limit(show[:scores].length)
  users.zip(show[:scores]).each do |(user, score)|
    s.ratings.create(user: user, score: score, review: Faker::Lorem.sentence(3))
  end
end
