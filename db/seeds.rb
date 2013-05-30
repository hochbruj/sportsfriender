mig_city = false
mig_citytexts = false
mig_sport = false
mig_assess = false
reset = true


if mig_assess == true
  Assessment.delete_all
  puts "Importing assessmentss..."
  CSV.foreach(Rails.root.join("seeds/assessments_en.csv"), headers: true) do |row|
      a = Assessment.new
      a.id = row[0].chop[1..-1]
      a.sport_id = row[1].chop[1..-1]
      a.level = row[2].chop[1..-1]
      a.cat1 = row[3].chop[1..-1]
      a.cat2 = row[4].chop[1..-1]
      a.cat3 = row[5].chop[1..-1]
      a.cat4 = row[6].chop[1..-1]
      a.cat5 = row[7].chop[1..-1]
      a.save!
  end


end

if mig_sport == true
  Sport.delete_all
  puts "Importing sports..."
  CSV.foreach(Rails.root.join("seeds/sports.csv"), headers: true) do |row|
      s = Sport.new
      s.id = row[0].chop[1..-1]
      s.name = row[1].chop[1..-1]
      s.cat1 = row[2].chop[1..-1]
      s.cat2 = row[3].chop[1..-1]
      s.cat3 = row[4].chop[1..-1]
      s.cat4 = row[5].chop[1..-1]
      s.cat5 = row[6].chop[1..-1]
      s.save!
  end
  
  I18n.locale = :de
  CSV.foreach(Rails.root.join("seeds/sports_de.csv"), headers: true, :encoding => "utf8") do |row|
    Sport.find(row[0].chop[1..-1]).update_attributes(:name => row[1].chop[1..-1], :cat1 => row[2].chop[1..-1], :cat2 => row[3].chop[1..-1],
    :cat3 => row[4].chop[1..-1], :cat4 => row[5].chop[1..-1], :cat5 => row[6].chop[1..-1])
  end
end



if mig_city == true
City.delete_all
puts "Importing cities..."
CSV.foreach(Rails.root.join("seeds/Cities.csv"), headers: true) do |row|
    city = City.new
    city.id = row[0].chop[1..-1]
    city.name = row[1].chop[1..-1]
    city.country = row[2].chop[1..-1]
    city.zone = row[3].chop[1..-1]
    city.lat = row[4].chop[1..-1].to_f
    city.lng = row[5].chop[1..-1].to_f
    city.save!
end
end

if mig_citytexts == true
puts "Importing Cittext..."

I18n.locale = :de
CSV.foreach(Rails.root.join("seeds/Citytexts_de.csv"), headers: true, :encoding => "utf8") do |row|
  City.find(row[0].chop[1..-1]).update_attributes(:name => row[2].chop[1..-1], :full_name => row[3].chop[1..-1])
end

I18n.locale = :en
CSV.foreach(Rails.root.join("seeds/Citytexts_en.csv"), headers: true, :encoding => "utf8") do |row|
  City.find(row[0].chop[1..-1]).update_attributes(:name => row[2].chop[1..-1], :full_name => row[3].chop[1..-1])
end  

end


if reset == true
  puts "Reseting data..."
  User.delete_all
  Rating.delete_all
  Stat.delete_all
  Event.delete_all
  EventPost.delete_all
  Message.delete_all
  Group.delete_all
  Member.delete_all
  Participant.delete_all
end