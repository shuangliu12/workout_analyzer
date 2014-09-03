require_relative 'workout'
require 'csv'
require 'table_print'
require 'pry'
# create a hash of workout info from CSV
def load_workout_data(filename)
  workouts = {}

  CSV.foreach(filename, headers: true, header_converters: :symbol, converters: :numeric) do |row|
    workout_id = row[:workout_id]

    if !workouts[workout_id]
      workouts[workout_id] = {
        date: row[:date],
        exercises: []
      }
    end

    exercise = {
      name: row[:exercise],
      category: row[:category],
      duration_in_min: row[:duration_in_min],
      intensity: row[:intensity]
    }

    workouts[workout_id][:exercises] << exercise
  end
  workouts

end

#code here

workouts_data = load_workout_data('workouts.csv')

results = []

workouts_data.each do |workoutKey, workoutValue|

  exercise = workoutValue[:exercises]

  summary = Workout.new(exercise)
  each_day = {
    id: workoutKey,
    date: workoutValue[:date],
    type: summary.type,
    duration: summary.duration,
    calories_burned: summary.calories_burned
  }
  results << each_day
end

tp results




