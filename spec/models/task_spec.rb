require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:priority).with_values(low: 0, medium: 1, high: 2).backed_by_column_of_type(:integer) }
    it { is_expected.to define_enum_for(:status).with_values(todo: 0, in_progress: 1, review: 2, done: 3, cancelled: 4).backed_by_column_of_type(:integer) }
  end

  describe 'scopes' do
    let(:user) { FactoryBot.create(:user) }

    describe '.updated_today' do
      let!(:today_task) { create(:task, updated_at: Time.current, user: user) }
      let!(:yesterday_task) { create(:task, updated_at: 1.day.ago, user: user) }

      it 'returns tasks updated today' do
        expect(Task.updated_today).to include(today_task)
        expect(Task.updated_today).not_to include(yesterday_task)
      end
    end

    describe '.by_priority' do
      let!(:low_priority_task) { create(:task, priority: :low, user: user) }
      let!(:medium_priority_task) { create(:task, priority: :medium, user: user) }
      let!(:high_priority_task) { create(:task, priority: :high, user: user) }

      it 'returns tasks filtered by priority' do
        expect(Task.by_priority('low')).to include(low_priority_task)
        expect(Task.by_priority('low')).not_to include(medium_priority_task, high_priority_task)

        expect(Task.by_priority('medium')).to include(medium_priority_task)
        expect(Task.by_priority('medium')).not_to include(low_priority_task, high_priority_task)

        expect(Task.by_priority('high')).to include(high_priority_task)
        expect(Task.by_priority('high')).not_to include(low_priority_task, medium_priority_task)
      end
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:priority) }
    it { is_expected.to validate_presence_of(:status) }
  end
end
