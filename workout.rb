class Workout

  attr_reader :each_workout

  def initialize(each_workout)
    @each_workout = each_workout
  end


  def duration
    duration = []
    @each_workout.each do |exercise|
      duration << exercise[:duration_in_min]
    end
    duration = duration.inject(0){ |sum, each_duration|
        sum +  each_duration
    }

  end

  def calories_burned
    calories = 0
    @each_workout.each do |exercise|
      if exercise[:category] == 'cardio'
        if exercise[:intensity] == 'high'
          calories += 10 * exercise[:duration_in_min]
        elsif exercise[:intensity] == 'medium'
          calories += 8 * exercise[:duration_in_min]
        # else exercise[:intensity] == 'low'
        else
          calories += 5 * exercise[:duration_in_min]
        end
      elsif exercise[:category] == 'strength'
          calories += 5 * exercise[:duration_in_min]
      else
          calories += 6 * exercise[:duration_in_min]
      end
    end
    calories
  end

  def type
    categories = []

    @each_workout.each do |exercise|
      categories << exercise[:category]
    end

    categories
    if categories.count('cardio') >= categories.length/2.to_f
      'cardio'
    elsif categories.count('strength') >= categories.length/2.to_f
      'strength'
    else
      'other'
    end
  end

end


