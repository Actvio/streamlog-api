
require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  before(:each) do
    @user = FactoryBot.create(:user)

    command = AuthenticateUser.call(@user, true)
    token = command.result[:auth_token]

    request.headers.merge!({'Authorization' => token})
  end

  describe '#index' do
    it 'should return project_attachment joins' do
      get :index
      res = JSON.parse(response.body)
      expect(res).to eq([])

      project = FactoryBot.create(:project, user: @user)
      clip = FactoryBot.create(:clip)

      project.clips.push(clip)
      project.save

      get :index
      res = JSON.parse(response.body)
      expect(res.length).to eq(1)

      p = res.first
      expect(p['project_attachments'].length).to eq(1)
      expect(p['project_attachments'].first['item_id']).to eq(clip.id)
      expect(p['project_attachments'].first['item_type']).to eq(Clip.name)
      expect(p['project_attachments'].first['project_id']).to eq(project.id)

      expect(p['clips'].length).to eq(1)
      expect(p['clips'].first['id']).to eq(clip.id)
    end
  end

  describe '#create' do
    it 'should create a project' do
      post :create, params: {project: {name: 'Project 1'}}
      res = JSON.parse(response.body)
      expect(res['id']).to eq(Project.last.id)
      expect(res['user_id']).to eq(@user.id)
    end
  end

  describe '#update' do
    it 'should update project attributes' do
      project = FactoryBot.create(:project, user: @user)

      put :update, params: {id: project.id, project: {name: 'Project 1'}}
      res = JSON.parse(response.body)
      expect(res['name']).to eq('Project 1')
    end

    it 'should update clips' do
      project = FactoryBot.create(:project, user: @user)
      clip1 = FactoryBot.create(:clip)
      clip2 = FactoryBot.create(:clip)

      project.clips.push(clip1)
      project.save

      put :update, params: {id: project.id, project: {
        project_attachments_attributes: [
          {item_type: Clip.name, item_id: clip2.id}
        ]
      }}
      res = JSON.parse(response.body)
      expect(res['project_attachments'].length).to eq(2)

      put :update, params: {id: project.id, project: {
        project_attachments_attributes: [
          {id: res['project_attachments'].first['id'], _destroy: true}
        ]
      }}
      res = JSON.parse(response.body)
      expect(res['project_attachments'].length).to eq(1)
    end
  end

  describe '#clips' do
    it 'should return clips' do
      project = FactoryBot.create(:project, user: @user)
      clip1 = FactoryBot.create(:clip)
      clip2 = FactoryBot.create(:clip)

      project.clips = [clip1, clip2]
      project.save

      get :clips, params: {id: project.id}
      res = JSON.parse(response.body)
      expect(res.length).to eq(2)
    end
  end

  describe '#add_clip' do
    it 'should add the clip' do
      project = FactoryBot.create(:project, user: @user)
      clip1 = FactoryBot.create(:clip)
      clip2 = FactoryBot.create(:clip)

      project.clips = [clip1]
      project.save

      put :add_clip, params: {id: project.id, clip_id: clip2.id}
      res = JSON.parse(response.body)
      expect(res['project_attachments'].length).to eq(2)
    end
  end

  describe '#remove_clip' do
    it 'should remove the clip' do
      project = FactoryBot.create(:project, user: @user)
      clip1 = FactoryBot.create(:clip)
      clip2 = FactoryBot.create(:clip)

      project.clips = [clip1, clip2]
      project.save

      put :remove_clip, params: {id: project.id, clip_id: clip2.id}
      res = JSON.parse(response.body)
      expect(res['project_attachments'].length).to eq(1)
    end
  end
end