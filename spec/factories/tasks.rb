FactoryBot.define do
  factory :task do
    title { 'Sample Task' }
    description { 'This is a sample task' }
    priority { :low }
    status { :todo }
    user
  end
end
