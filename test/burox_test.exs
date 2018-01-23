defmodule BuroxTest do
  use ExUnit.Case
  # doctest Burox

  @valid_person_data %{}

  @invalid_person_data %{}

  test "Gets the information of a person in Buro de Crédito" do
    assert Burox.request_info(@valid_person_data) == {:ok}
  end

  test "Gets an error tryingto get information of a person in Buro de Crédito" do
    assert Burox.request_info(@invalid_person_data) == {:ok}
  end

end
