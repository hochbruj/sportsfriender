mig_sport = true
mig_assess = true
mig_users = false

if mig_assess == true
  Assessment.delete_all
  puts "Importing assessmentss..."
  CSV.foreach(Rails.root.join("seeds/assess2.csv"), headers: true) do |row|
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




if mig_users == true
  User.all.each do |u|
    u.lat = 52.5200066
    u.lng = 13.404954
    u.country_code = 'DE'
    u.city_id = '6b1afbd7fcf2ec16ff8e2f95514e2badb8c2451d'
    u.city_reference = 'CoQBcgAAAGPfLi7HewnhPVGBPh8hb3vptaUmdihOmQUhYSxkN7ZXGxA91wGRWRYpv_Kb4P1u0sAyxgDklopnxmqpJZRn9JNvdTCMPd5hTmmGu-D3oND-dkgwGPN2L3SF5oR5xru_1qcT_ALdS3z6re3jO7CRR19bw8I7xUNkubFPBMe9MJSREhAmdE0jC2dfIXBnyhwJBf9ZGhST5AHo6rFGlBPZ7QaAuzsg0KlTgA'
    u.save!
  end
end