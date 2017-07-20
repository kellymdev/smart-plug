require 'rails_helper'

RSpec.describe PlugsController, type: :controller do
  render_views

  let(:plug) { Plug.create!(name: 'Test Plug', login_user: 'admin', login_password: '1234', ip_address: '127.0.0.1') }

  let(:valid_params) do
    {
      plug: {
        name: 'Valid Plug',
        login_user: 'admin',
        login_password: '1234',
        ip_address: '127.0.0.1'
      }
    }
  end

  let(:invalid_params) do
    {
      plug: {
        name: 'Invalid Plug',
        login_user: 'admin',
        login_password: '1234',
        ip_address: '127.0'
      }
    }
  end

  describe '#index' do
    it 'renders the index template' do
      get :index

      expect(response).to render_template(:index)
    end
  end

  describe '#new' do
    it 'renders the new template' do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe '#create' do
    context 'with valid plug params' do
      it 'creates a new plug' do
        expect { post :create, params: valid_params }.to change { Plug.count }.by 1
      end

      it 'redirects to the newly created plug' do
        post :create, params: valid_params

        expect(response).to redirect_to Plug.last
      end
    end

    context 'with invalid params' do
      it 'does not create a new plug' do
        expect { post :create, params: invalid_params }.to change { Plug.count }.by 0
      end

      it 'renders the new template' do
        post :create, params: invalid_params

        expect(response).to render_template :new
      end
    end
  end

  describe '#show' do
    it 'renders the show template' do
      get :show, params: { id: plug.id }

      expect(response).to render_template :show
    end
  end

  describe '#edit' do
    it 'renders the edit template' do
      get :edit, params: { id: plug.id }

      expect(response).to render_template :edit
    end
  end

  describe '#update' do
    context 'with valid params' do
      it 'updates the plug details' do
        patch :update, params: valid_params.merge(id: plug.id)

        expect(plug.reload.name).to eq 'Valid Plug'
      end

      it 'redirects to the plug' do
        patch :update, params: valid_params.merge(id: plug.id)

        expect(response).to redirect_to @plug
      end
    end

    context 'with invalid params' do
      it 'does not update the plug details' do
        patch :update, params: invalid_params.merge(id: plug.id)

        expect(plug.reload.name).to eq 'Test Plug'
      end

      it 'renders the edit template' do
        patch :update, params: invalid_params.merge(id: plug.id)

        expect(response).to render_template :edit
      end
    end
  end
end
