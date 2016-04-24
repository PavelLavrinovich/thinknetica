class PassangerTrain < SpecialTrain
  def initialize(number, type, carriages)
    super(number, type, carriages, PassangerCarriege)
  end
end
