class PassangerTrain < Train
  def initialize(number, type, carriages)
    super(number, type, carriages, PassangerCarriage)
  end
end
