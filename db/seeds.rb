mig_sport = true
mig_assess = true
mig_assess_de = true


if mig_sport == true
  Sport.delete_all
  I18n.locale = :en
  puts "Importing sports...english"
  CSV.foreach(Rails.root.join("seeds/sports.csv"), headers: true) do |row|
      s = Sport.new
      s.name = row[1].chop[1..-1]
      s.cat1 = row[2].chop[1..-1]
      s.cat2 = row[3].chop[1..-1]
      s.cat3 = row[4].chop[1..-1]
      s.cat4 = row[5].chop[1..-1]
      s.cat5 = row[6].chop[1..-1]
      s.save!
  end


  puts "Importing sports...deutsch"
  CSV.foreach(Rails.root.join("seeds/sports_de.csv"), headers: true, :encoding => "utf8") do |row|
    I18n.locale = :en
    s = Sport.find_by_name(row[0].chop[1..-1])
    I18n.locale = :de
    s.update_attributes(:name => row[1].chop[1..-1], :cat1 => row[2].chop[1..-1], :cat2 => row[3].chop[1..-1],
    :cat3 => row[4].chop[1..-1], :cat4 => row[5].chop[1..-1], :cat5 => row[6].chop[1..-1])
  end
end

if mig_assess == true
  Assessment.delete_all
  I18n.locale = :en
  puts "Importing assessmentss..."
  CSV.foreach(Rails.root.join("seeds/assess3.csv"), headers: true) do |row|
      s = Sport.find_by_name(row[1].chop[1..-1])
      s.assessments.create(level:row[2].chop[1..-1], cat1:row[3].chop[1..-1], cat2:row[4].chop[1..-1], cat3:row[5].chop[1..-1], cat4:row[6].chop[1..-1], cat5:row[7].chop[1..-1])   
  end

end

if mig_assess_de == true
  puts "Importing assessmentss in german..."
  I18n.locale = :de
   CSV.foreach(Rails.root.join("seeds/assess3_de.csv"), headers: true, :encoding => "utf8") do |row|
     s = Sport.find_by_name(row[1].chop[1..-1])
     s.assessments.find_by_level(row[2].chop[1..-1]).update_attributes(:cat1 => row[3].chop[1..-1], :cat2 => row[4].chop[1..-1], :cat3 => row[5].chop[1..-1],
     :cat4 => row[6].chop[1..-1], :cat5 => row[7].chop[1..-1])
   end
end
