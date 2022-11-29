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
      expect(p.clips.first.id).to eq(clip.id)
    end

    it 'should be able to attach audio files' do
      audio_file = FactoryBot.create(:audio_file)
      @project.audio_files.push(audio_file)

      p = Project.find(@project.id)
      expect(p.audio_files.first.id).to eq(audio_file.id)
    end
  end
end
