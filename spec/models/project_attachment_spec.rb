require 'rails_helper'

RSpec.describe ProjectAttachment, type: :model do
  describe 'add attachments to project' do
    before :each do
      @project = FactoryBot.create(:project)
    end

    it 'should be able to attach clips' do
      clip = FactoryBot.create(:clip)
      @project.clips.push(clip)

      p = Project.find(@project.id)
      expect(p.clips.first.id).to 