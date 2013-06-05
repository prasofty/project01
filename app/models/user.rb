class MyValidator < ActiveModel::Validator
  def validate(record)
    if record.first_name.starts_with? 'x'
      record.errors[:first_name] << 'dont starting with x please!'
    end
  end
end


class User < ActiveRecord::Base
  include ActiveModel::Validations
  attr_accessible :about_me, :accept_terms, :dob, :education_degree, :email, :first_name, :gender, :graduate, :is_passed, :last_name, :salary, :year,
                  :email_confirmation

  validates :first_name, :presence => true
  validates :last_name, :presence => true#, :if => :validate_last_name?, :unless

  validates :email, :uniqueness => true, :allow_blank => true
  validates :email, :confirmation => true
  validates :email_confirmation, :presence => true

  validates :accept_terms, :acceptance => {:accept => true}, :on => :create

  validates :first_name, :format => { :with => /\A[a-zA-Z]+\z/,
                                      :message => "Only letters allowed" }

  #validates :about_me, :length => { :minimum => 10, :maximum => 100 }
  #validates :about_me, :length => { :in => 10..50 }
  #validates :about_me, :length => { :is => 20 }
  validates :about_me, :length => {
    :minimum   => 10,
    :maximum   => 15,
    :tokenizer => lambda { |str| str.scan(/\w+/) },
    :too_short => "must have at least %{count} words",
    :too_long  => "must have at most %{count} words"
  }

  #validates :salary, :numericality => true
  validates :salary, :numericality => { :only_integer => true, :greater_than => 2000}

  validates :gender, :inclusion => { :in => %w(male female),
                                     :message => "%{value} is not a gender" }

  validates :graduate, :exclusion => { :in => %w(ssc inter),
                                       :message => "%{value} not accept graduate." }

  validates_with MyValidator


  def validate_last_name?
    false
  end
end
