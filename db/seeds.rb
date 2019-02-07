owner = Owner.find_by(:name =>'master_shelter_2', :o_type => 'shelter')
if owner == nil
  Owner.create(name: 'master_shelter_2', o_type: 'shelter', password: '1234')
end
