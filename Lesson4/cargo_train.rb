class CargoTrain < SpecialTrain
  def initialize(number, type, carriages)
    super(number, type, carriages, CargoCarriage)
  end
end
