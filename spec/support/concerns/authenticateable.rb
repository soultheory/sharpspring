require 'spec_helper'

shared_examples_for 'authenticateable' do
  let(:email) { "admin+#{SecureRandom.hex(4)}@app.com" }
  let(:password) { BCrypt::Password.create("password") }
  let(:subject) {
    described_class.new({
      first_name: "Admin",
      last_name: "User",
      email: email,
      password: password
    })
  }

  # Model
  it { is_expected.to be_mongoid_document }
  it { is_expected.not_to be_dynamic_document }
  it { is_expected.to have_timestamps }
  it { is_expected.to be_stored_in(database: "notes_#{Rails.env}", collection: described_class.to_s.downcase.pluralize, client: :default) }

  # Fields
  it { is_expected.to have_fields(:first_name, :last_name, :email, :reset_password_token).of_type(String) }
  it { is_expected.to have_fields(:reset_password_date).of_type(Date) }
  it { is_expected.to have_fields(:created_at, :updated_at).of_type(Time) }
  it { is_expected.to have_fields(:password).of_type(BCrypt::Password) }

  # Validations
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { should validate_length_of(:first_name).with_minimum(2).with_maximum(50) }
  it { should validate_length_of(:last_name).with_minimum(2).with_maximum(50) }
  it { should validate_length_of(:password).with_minimum(60).with_maximum(80) }
  it { should validate_length_of(:email).with_maximum(50) }

  it "is not valid with invalid attributes" do
    expect(described_class.new).not_to be_valid
  end

  it "is not valid with incorrect email" do
    subject.email = 'abc'
    expect(subject).not_to be_valid
    subject.email = '12321.com'
    expect(subject).not_to be_valid
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "has an encrypted password" do
    expect(subject.password).not_to eq("password")
    expect(subject.password.start_with?("$")).to eq(true)
    expect(BCrypt::Password.new(subject.password)).to eq("password")
  end

end
