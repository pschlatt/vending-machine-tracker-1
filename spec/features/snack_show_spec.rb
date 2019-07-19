require "rails_helper"

RSpec.describe "User can see snack show page" do
  before :each do
    @sam = Owner.create(name: "Sam's Snacks")
    @machine_1 = @sam.machines.create(location: "Don's Mixed Drinks")
    @machine_2 = @sam.machines.create(location: "Turing Basement")
    @machine_3 = @sam.machines.create(location: "Ya momma house")
    @snack_1 = Snack.create!(name: "Cheetos", price: 2.99)
    @snack_2 = Snack.create!(name: "Caprisun", price: 0.99)
    @snack_3 = Snack.create!(name: "Snickers", price: 1.99)
    @machine_1.snacks << @snack_2
    @machine_1.snacks << @snack_3
    @machine_3.snacks << @snack_3
    @snack_1.machines << @machine_2
    @snack_1.machines << @machine_3
  end

  it "user can see snack info" do
    visit "/snacks/#{@snack_1.id}"

    expect(page).to have_content("Price: $2.99")
    expect(page).to have_content("Locations: #{@machine_2.location} - Average Price: #{@machine_2.average_snack_price} - Count: #{@machine_2.count_snack} #{@machine_3.location} - Average Price: #{@machine_3.average_snack_price} - Count: #{@machine_3.count_snack}")


  end


end

# As a visitor
# When I visit a snack show page
# I see the name of that snack
#   and I see the price for that snack
#   and I see a list of locations with vending machines that carry that snack
#   and I see the average price for snacks in those vending machines
#   and I see a count of the different kinds of items in that vending machine.
