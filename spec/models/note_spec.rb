require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:user) {
    User.find("5e49fe2cae98823cf3667eee")
  }

  # Model
  it { is_expected.to be_mongoid_document }
  it { is_expected.not_to be_dynamic_document }
  it { is_expected.to have_timestamps }
  it { is_expected.to be_stored_in(database: "notes_#{Rails.env}", collection: described_class.to_s.downcase.pluralize, client: :default) }

  # Fields
  it { is_expected.to have_fields(:title, :body).of_type(String) }

  # Validations
  it { should validate_length_of(:title).with_maximum(30) }
  it { should validate_length_of(:body).with_maximum(1000) }

  it "should throw an error if title is not provided" do
    note = described_class.create({ title: nil, body: nil })
    expect(note.valid?).to eq(false)
    expect(note.errors.messages[:validate_title_and_body][0]).to eq("Title and Body are required")
  end

  it "should throw an error if title is longer than 30 characters" do
    note = described_class.create({ title: ('a'*50), body: nil })
    expect(note.valid?).to eq(false)
    expect(note.errors.messages[:title][0]).to eq("is too long (maximum is 30 characters)")
  end

  it "should throw an error if body is longer than 1000 characters" do
    note = described_class.create({ title: nil, body: ('a'*1500) })
    expect(note.valid?).to eq(false)
    expect(note.errors.messages[:body][0]).to eq("is too long (maximum is 1000 characters)")
  end

  it "should throw an error if user is not provided" do
    expect{described_class.create({ title: nil, body: 'Some Body' })}.to raise_error(Mongoid::Errors::NoParent)
  end

  it "should create note if just the title is provided" do
    note = described_class.create({ title: "Some Note Title", body: nil, user: user })
    expect(note.valid?).to eq(true)
  end

  it "should create note if the title and body is provided" do
    note = described_class.create({ title: "Some Note Title", body: "Some Body", user: user })
    expect(note.valid?).to eq(true)
  end

  it "should create note with the title as the first 30 characters if just the body is provided and is less than 1000 characters" do
    note = described_class.create({
      title: nil,
      body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
             Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
             when an unknown printer took a galley of type.",
      user: user
    })
    expect(note.valid?).to eq(true)
    expect(note.title).to eq("Lorem Ipsum is simply dummy te")
  end

  # Associations
  it { should be_embedded_in(:user) }
end
