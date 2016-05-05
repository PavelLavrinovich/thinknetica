class CargoTrain < Train
  def initialize(number, carriages)
    super(number, "cargo", carriages)
  end
end
