module SearchHelper
  def distance_formatter(lat_and_long)
    if lat_and_long <= 0.49
      "Less than a mile away"
    elsif lat_and_long <= 1.99
      "1 mile away"
    else
      "#{number_with_precision(lat_and_long, precision: 0)} miles away"      
    end 
  end
end