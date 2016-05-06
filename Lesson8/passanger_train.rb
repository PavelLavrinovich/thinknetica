# Class for work with passanger trains
class PassangerTrain < Train
  def initialize(number, carriages)
    super(number, :passanger, carriages)
  end
end
