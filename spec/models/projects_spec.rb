require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'adding clips' do

    before (:each) do
      @user = FactoryBot.create(:user)
      @project = FactoryBot.create(:project, user: @user)
    end

    it 'should save a clip in its collection' do
      clip = FactoryBot.create(:clip)

      @project.clips.push(clip)
      @project.save

      p = Project.find(@project.id)
      expect(p.clips.length).to eq(1)
    end

    it 'should accept clips as attributes' do
      clip = FactoryBot.create(:clip)

      @project.update({
        project_attachments_attributes: [
          {item_type: Clip.name, item_id: clip.id},
        ],
      })

      p = Project.find(@project.id)
      expect(p.clips.length).to eq(1)

      clip2 = FactoryBot.create(:clip)
      @project.update({
        project_attachments_attributes: [
          {item_type: Clip.name, item_id: clip.id},
        ],
      })

      p = Project.find(@project.id)
      expect(p.clips.length).to eq(2)

      @project.update({
        project_attachments_attributes: [
          {id: @project.project_attachments.first.id, _destroy: true},
        ],
      })

      p = Project.find(@project.id)
      expect(p.clips.length).to eq(1)
    end
  end
end
