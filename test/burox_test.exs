defmodule BuroxTest do
  use ExUnit.Case
  alias Burox.Request

  @valid_person_data %{
    person: %{
      name: nil,
      middle_name: nil,
      last_name: nil,
      last_name_2: nil,
      birth_date: nil,
      rfc: nil,
    },
    address: %{
      street: nil,
      settlement: nil,
      municipality: nil,
      city: nil,
      state: nil,
      zip_code: nil
    },
    credit: %{
      credit_card: nil,
      card_4_last_digits: nil,
      mortage?: nil,
      car_credit?: nil
    }
  }

  @invalid_person_data %{
    person: %{
      name: nil,
      middle_name: nil,
      last_name: nil,
      last_name_2: nil,
      birth_date: nil,
      rfc: nil,
    },
    address: %{
      street: nil,
      settlement: nil,
      municipality: nil,
      city: nil,
      state: nil,
      zip_code: nil
    }
  }

  test "Gets the information of a person in Buro de Crédito" do
    assert Burox.solicitar(@valid_person_data) == {:ok}
  end

  test "Gets an error trying to get information of a person in Buro de Crédito" do
    assert Burox.solicitar(@invalid_person_data) == {:invalid}
  end

end
