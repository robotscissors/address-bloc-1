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

end
