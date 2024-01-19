class Drama < ApplicationRecord
    validates :title, presence: true, length: {minimum:5, maximum:50}
    validates :overview, presence: true, length: {minimum:10, maximum:300}
end
