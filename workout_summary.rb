require_relative 'workout'
require 'csv'
require 'table_print'

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



workouts_data = load_workout_data('workouts.csv')

results = []

counter = 1
while counter <= workouts_data.length

  exercise = workouts_data[counter][:exercises]

  summary = Workout.new(exercise)
  each_exercise = {
    id: counter,
    date: workouts_data[counter][:date],
    type: summary.type,
    duration: summary.duration,
    calories_burned: summary.calories_burned
  }

  results << each_exercise

  counter += 1
end

tp results




