require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'adding clips' do

    before (:each) do
      @user = FactoryBot.create(:user)
      @project = FactoryBot.create(:project, user: @user)
    end

    it 'shou