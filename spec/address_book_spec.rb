require_relative '../models/address_book'
require_relative '../models/entry'
require 'bloc_record'


BlocRecord.connect_to('db/address_bloc.sqlite')
#book = AddressBook.create(name: 'My Address Book')

RSpec.describe AddressBook do
   #let(:book) {AddressBook.create(name: 'My Address Book')}
   #let(:entry) {Entry.create(address_book_id: book.id, name: 'Foo One', phone_number: '999-999-9999', email: 'foo_one@gmail.com' )}
   #let(:entry2) {Entry.create(address_book_id: book.id, name: 'Christopher', phone_number: '333-333-3333', email: 'cjbazin@gmail.com' )}


  describe "attributes" do
    it "returns an array like an ORM" do
      expect(Entry.all).to be_an(Array)
    end

    it "responds to first element with chaining" do
      expect(Entry.first.phone_number).to eq('999-999-9999')
    end

    it "Responds to find(id)" do
      expect(Entry.find(1).name).to eq('Foo One')
    end
   end

  describe "error checking in methods" do
    it "responds and fails gracefully to bad ids" do
      # expect(Entry.find_one(-1)).to output("some output").to_stdout
      expect {Entry.find(-1)}.to output("Invalid ID - ID must be greater than or equal to zero\n").to_stdout
    end
    it "responds to errors when strings are sent instead of numbers" do
      expect {Entry.take("a")}.to output("Invalid value - this must contain a number\n").to_stdout
    end
  end

  describe "method_missing" do
    it "responds to find_by_name" do
      #puts "#{Entry.find_by_name('Christopher')}"
      expect(Entry.find_by_name('Christopher').phone_number).to eq("232-203-2233")
    end
    it "responds to phone" do
      #puts "#{Entry.find_by_name('Christopher')}"
      expect(Entry.find_by_phone('232-203-2233').name).to eq("Christopher")
    end
  end

  describe "Check update function" do
    #reset
    Entry.update(1, name: 'Foo One')
    Entry.update(2, name: 'Foo Two')

    it "updates entry 1 name to BBAAZZIINN" do
      Entry.update(1, name: 'BBAAZZIINN')
      expect(Entry.find(1).name).to eq('BBAAZZIINN')
    end
    it "updates multiple ids with multiple items" do
      people = { 1 => { "name" => "David" }, 2 => { "name" => "Jeremy" } }
      Entry.update(people.keys, people.values)
      expect(Entry.find(1).name).to eq('David')
      expect(Entry.find(2).name).to eq('Jeremy')
    end

  end

  describe "Missing method - update", focus: true do
    #reset
    Entry.update(1, name: 'Foo One')
    Entry.update(2, name: 'Foo Two')
    person = Entry.find(1)

    it "updates entry 1 name to CCHHRRIISS" do
      person.update_attribute(:name, "CCHHRRIISS")
      person = Entry.find(1)
      expect(person.name).to eq('CCHHRRIISS')
    end
  end

  describe "Where collection methods" do
    #reset
    Entry.update(1, name: 'Foo One')
    Entry.update(2, name: 'Foo Two')

    it "Select where first name is Foo One" do
      person = Entry.where(name: "Foo One").take
      expect(person[0].name).to eq('Foo One')
    end
    it "Select where uses double where" do
      person = Entry.where(Email: "foo_one@gmail.com").where(name: "CCHHRRIISS")
      puts "#{person}"
      expect(person[0].name).to eq('CCHHRRIISS')
    end

    it "Select items using NOT" do
      person = Entry.where.not(Email: "foo_one@gmail.com")
    end

  end

  describe "Delete collection methods" do
    it "deletes only those apart of the collection" do
      Entry.where(name: 'Foo One').destroy_all
    end
  end


end
