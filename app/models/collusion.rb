class Collusion < PostCustomField
  validates        :user,    presence: true
  validates        :post,    presence: true
  validates        :length,  numericality: { greater_than: 0 }
  validates        :version, numericality: { greater_than: 0 }
  after_initialize :set_name

  def self.collusion_accessor(*fields)
    Array(fields).each do |field|
      define_method field,        ->      { collusion[field] }
      define_method :"#{field}=", ->(val) { collusion[field] = val }
    end
  end

  def user
    @user ||= User.find_by(id: user_id)
  end

  def user=(u)
    self.user_id = u.id
  end

  def set_name
    self.name ||= :collusion
  end

  collusion_accessor :user_id, :length, :version
end
