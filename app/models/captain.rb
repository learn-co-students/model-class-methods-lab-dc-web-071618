class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).distinct.where({
      classifications: {
        name: 'Catamaran'
      }
    })
  end

  def self.sailors
    includes(boats: :classifications).distinct.where({
      classifications: {
        name: 'Sailboat'
      }
    })
  end

  def self.motorboat_operators
    joins(boats: :classifications).distinct.where({
      classifications: {
        name: 'Motorboat'
      }
    })
  end

  def self.talented_seafarers
    where('id IN (?)', sailors.pluck(:id) & motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    where('id NOT IN (?)', sailors.pluck(:id))
  end
end
