
require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe 'parent and children' do
    it 'should have a parent and children' do
      f1 = FactoryBot.create(:folder)
      f2 = FactoryBot.create(:folder, parent_id: f1.id)
      f3 = FactoryBot.create(:folder)
      f2.children.push(f3)
      f2.save

      expect(f2.parent.id).to eq(f1.id)
      expect(f2.children.first.id).to eq(f3.id)
    end
  end

  describe 'folder members' do
    it 'should be able to contain audio files' do
        a = FactoryBot.create(:audio_file)
        f = FactoryBot.create(:folder)

        fm = FactoryBot.create(:folder_item, folder: f, item: a)
        fm.save

        expect(a.folders.first.id).to eq(f.id)
        expect(f.items.first.id).to eq(a.id)
        expect(f.audio_files.first.id).to eq(a.id)