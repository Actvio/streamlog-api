require 'rails_helper'

RSpec.describe ProjectAttachment, type: :model do
  describe 'add attachments to project' do
    before :each do
      @project = FactoryBot.create(:project)
    end

    it 'should be 