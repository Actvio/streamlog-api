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
      clip =