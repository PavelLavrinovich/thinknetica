class CargoTrain < Train
  def initialize(number, type, carriages)
    super(number, type, carriages, CargoCarriage)
  end
end
