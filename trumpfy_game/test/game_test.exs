defmodule GameTest do
  use ExUnit.Case
  alias TrumpfyGame.{Game}
  alias Game.{Card}

  test "deal" do
    hand = (1..5) |> Enum.to_list 
    assert Game.deal(hand, 2) == [ [1,2], [3,4] ]
  end

  test "play" do
    cards = make_cards(2)
    game = Game.deal(cards, 2)
    {[p1, p2], winner} = game |> Game.play(0)
    
    assert winner == 0
    assert length(p1) == 2
    assert length(p2) == 0
    assert p1 |> Enum.member?(%Card{id: 2, attributes: [0,1]})
  end

  test "finished" do
    cards = make_cards(4)
    game = Game.deal(cards, 2)

    {game,_} = game |> Game.play(0)
    assert Game.finished(game) == false
    assert Game.winner(game) == nil

    {game,_} = game |> Game.play(1)
    assert Game.finished(game) == true
    assert Game.winner(game) == 0
  end

  def make_cards(attribute_count) do
    (1..attribute_count)
    |> Enum.map( &(make_card(&1, attribute_count)) )
  end

  def make_card(winning_at, attribute_count) do
    %Card{
      id: winning_at,
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
