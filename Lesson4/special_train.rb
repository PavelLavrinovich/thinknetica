class SpecialTrain < Train
  attr_reader :carriage_type

  def initialize(number, type, carriages, carriage_type)
    super
    @carriage_type = carriage_type
  end

  def add_carriage(carriage)
    super if is_special?(carriage)
  end

  def delete_carriage(carriage)
    super if is_special?(carriage)
  end

  protected # SpecialTrain has subclasses, submethod for main methhods

  def is_special?(carriage)
    carriage.class == carriage_type
  end
end
