
require 'rails_helper'

RSpec.describe OtherFilesController, type: :controller do
  before(:each) do
    @user = init_user(request)
  end

  describe '#index' do