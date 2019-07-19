require "rails_helper"

RSpec.describe "User can see vending machine show page" do
  before :each do
    @sam = Owner.create(name: "Sam's Snacks")
    @machine_1 = @sam.machines.create(location: "Don's Mixed Drinks")
    @machine_2 = @sam.machines.create(location: "Turing Basement")
    @snack_1 = Snack.create!(name: "Cheetos", price: 2.99)
    @snack_2 = Snack.create!(name: "Caprisun", price: 0.99)
    @snack_3 = Snack.create!(name: "Snickers", price: 1.99)
    @machine_1.snacks << @snack_2
    @machine_1.snacks << @snack_3
    @machine_2.snacks << @snack_1
  end

  it "user can see all snacks and their price" do
    visit "/machines/#{@machine_1.id}"

    expect(page).to have_content("Caprisun: $0.99")
    expect(page).to have_content("Snickers: $1.99")

    visit "/machines/#{@machine_2.id}"

    expect(page).to have_content("Cheetos: $2.99")

  end

  it "user can see average price for all snacks in machine" do
    expect(@machine_1.average_snack_price).to eq(1.49)

    visit "/machines/#{@machine_1.id}"

    expect(page).to have_content("Average Price: $1.49")

    visit "/machines/#{@machine_2.id}"

    expect(page).to have_content("Average Price: $2.99")

  end


end

# As a visitor
# When I visit a vending machine show page
# I also see an average price for all of the snacks in that machine
