# Module for displaying a help by console
module HelpConsole
  protected

  def help
    display_header
    display_create_help
    display_read_help
    display_update_help
    display_footer
  end

  def display_header
    puts ''
    puts 'Input'
    puts '"exit" for exit'
  end

  def display_create_help
    puts '"create_test_data" for create test data'
    puts '"create_station" for create a station'
    puts '"create_train for create a train'
  end

  def display_read_help
    puts '"display_stations" for display your stations'
    puts '"display_station_trains" for display the trains on the station'
    puts '"display_train_carriages" for display the carriages of the train'
  end

  def display_update_help
    puts '"add_carriage" for add a carriage'
    puts '"delete_carriage" for delete a carriage'
    puts '"move_train" for move a train'
    puts '"take_a_place" for take a place'
    puts '"fill_capacity" for fill some capacity'
  end

  def display_footer
    puts ''
  end
end
