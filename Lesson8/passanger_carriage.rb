class PassangerCarriage < Carriage
  ONE_PLACE = 1

  def take_a_place
    fill(ONE_PLACE)
  end
end
