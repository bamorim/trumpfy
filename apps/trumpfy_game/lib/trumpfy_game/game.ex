defmodule TrumpfyGame.Game do
  alias TrumpfyGame.{Card, Deck}

  @moduledoc """
  A game of N players is an array of N hands
  A hand of M cards is an array of M cards
  A card with K attributes is an array of K integers
  
  So the structure for a game is something like
  [
    [
      [1,2,100,4,5],
      [2,4,200,10,10]
    ],
    [
      [1,2,3,4,5],
      [10,5,30,50,11]
    ]
  ]
  """
  
  @doc """
  Shuffle the deck and then give them to players
  """
  def new(deck, number_of_players) do
    Deck.cards(deck)
    |> Enum.shuffle
    |> deal(number_of_players)
  end

  @doc """
  Give a already shuffled deck to some players
  """
  def deal(cards, number_of_players) do
    cards_per_player = length(cards) |> div(number_of_players)

    cards 
    |> Enum.chunk(cards_per_player)
  end

  def finished?(game) do
    non_empty_hand_count =
      game
      |> Enum.filter( &(length(&1) != 0) )
      |> length

    non_empty_hand_count == 1
  end

  def winner(game) do
    if(finished?(game)) do
      game
      |> Stream.with_index
      |> Enum.filter(fn {hand,_i} -> length(hand) > 0 end)
      |> Enum.map(fn {hand, i} -> i end)
      |> List.first
    end
  end

  def playing_cards(game) do
    playing_cards =
      game
      |> Enum.map( &List.first/1 )
  end

  @doc """
  Given a game G and a attribute A, play one round.
  The player who have the top card with the highest value o A wins.
  The player who wins should get all the cards of the round and put them
  on the back of the deck.
  The cards of the round are each player's card on top of their decks

  HERE BE DRAGONS:
  We are not verifying if the attribute is in the range of attributes
  """
  def play(game, attribute) do
    winner = round_winner(game, attribute)
    newGame = game |> transfer_cards_to(winner)
    { newGame, winner }
  end

  defp round_winner(game, attribute) do
    {_cards, winner} =
      game
      |> playing_cards
      |> Stream.with_index
      |> Enum.filter( fn {card,_} -> card != nil end )
      |> Enum.max_by( fn {card,_} -> Card.attribute_value(card,attribute) end )

    winner
  end

  defp transfer_cards_to(game, winner) do
    won_cards =
      game
      |> Enum.map(&List.first/1)
      |> Enum.reject( &( is_nil(&1) ) )
      |> Enum.shuffle

    game
    |> Stream.with_index
    |> Enum.map(fn
      {cards, ^winner} -> cards |> Enum.drop(1) |> Enum.concat(won_cards)
      {cards, _} -> cards |> Enum.drop(1)
    end)
  end
end
