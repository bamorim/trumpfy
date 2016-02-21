# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TrumpfyWeb.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

deck = %TrumpfyWeb.Deck{
  name: "Kittens",
  attribute_name1: "Cuteness",
  attribute_name2: "Ownness",
  attribute_name3: "Devilness",
  attribute_name4: "Randomness"
} 

deck = TrumpfyWeb.Repo.insert!(deck)

for i <- (1..30) do
  card = %TrumpfyWeb.Card{
    deck_id: deck.id,
    name: "Random Cat ##{i}",
    image_url: "http://loremflickr.com/320/240/kitten",
    attribute1: :rand.uniform(100),
    attribute2: :rand.uniform(100),
    attribute3: :rand.uniform(100),
    attribute4: :rand.uniform(100)
  }
  TrumpfyWeb.Repo.insert!(card)
end


