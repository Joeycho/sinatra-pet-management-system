owner = Owner.find_by(:name =>'heaven_shelter', :o_type => 'shelter')
if owner == nil
  Owner.create(name: 'heaven_shelter', o_type: 'shelter', password: '1234')
end
