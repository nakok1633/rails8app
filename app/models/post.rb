class Post < ApplicationRecord
  CATEGORIES = {
    '🏃 운동' => 'exercise',
    '🍽️ 식사' => 'meal',
    '😴 수면' => 'sleep',
    '📚 공부' => 'study',
    '🎮 여가' => 'leisure',
    '👔 일' => 'work',
    '💪 건강' => 'health',
    '🎨 취미' => 'hobby',
    '✨ 일반' => 'general'
  }.freeze

  has_one_attached :image
  has_many_attached :images

  validates :title, presence: true
  validates :body, presence: true
  validates :category, inclusion: { in: CATEGORIES.values }
  validates :post_date, presence: true

  def category_label
    CATEGORIES.key(category) || CATEGORIES['✨ 일반']
  end

  belongs_to :user
end
