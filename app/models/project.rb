class Project < ActiveRecord::Base
  attr_accessible :description, :name
  validates :name, :presence => true, :uniqueness => true

  has_many :permissions, :as => :thing
  def self.viewable_by(user)
    joins(:permissions).where(:permissions => { :action => "view",
                                                :user_id => user.id })
  end

  has_many :tickets, :dependent => :delete_all
end
