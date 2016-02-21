defmodule TrumpfyGame.Helpers do
  alias TrumpfyGame.BasicCard

  def make_random_cards(attribute_count, card_count) do
    (1..card_count)
    |> Enum.map( &(make_random_card(&1,attribute_count)) )
  end

  def make_random_card(id, attribute_count) do
    %BasicCard{
      attributes: (1..attribute_count) 
        |> Enum.map( fn _ -> :rand.uniform(100) end )
    }
  end

  def make_cards(attribute_count) do
    (1..attribute_count)
    |> Enum.map( &(make_card(&1, attribute_count)) )
  end

  def make_card(winning_at, attribute_count) do
    %BasicCard{
      attributes: (1..attribute_count)
        |> Enum.map(fn i ->
          if i == winning_at do
            1
          else
            0
          end
        end)
    }
  end
end
