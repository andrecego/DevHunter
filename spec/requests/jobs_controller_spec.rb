require 'rails_helper'

describe 'Jobs Controller' do
  context 'show' do
    it 'should return all parameters' do
      hunter = create(:hunter, email: 'head@hunter.com')
      job = create(:job, title: 'Dev Ruby', description: 'Trabalhar com Rails', 
                         skills: 'TDD', position: 'intern', location: 'Remoto', 
                         min_wage: 999, max_wage: 3001, deadline: Date.tomorrow,
                         status: 'active', hunter: hunter )

      get api_v1_job_path(job.id)
      json = JSON.parse(response.body, symbolize_names: true) 
  
      expect(response).to have_http_status(:ok)
      expect(json[:title]).to eq('Dev Ruby')
      expect(json[:description]).to eq('Trabalhar com Rails')
      expect(json[:skills]).to eq('TDD')
      expect(json[:position]).to eq('intern')
      expect(json[:location]).to eq('Remoto')
      expect(json[:min_wage]).to eq(999)
      expect(json[:max_wage]).to eq(3001)
      expect(json[:deadline]).to eq(I18n.localize(Date.tomorrow, format: "%Y-%m-%d"))
      expect(json[:status]).to eq('active')
      expect(json[:hunter_id]).to eq(hunter.id)
    end

    it 'should return 404 when id not found' do
      get api_v1_job_path(999)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:not_found)
      expect(json[:message]).to eq("Couldn't find Job with 'id'=999")
    end
  end

  context 'index' do
    it 'should list all jobs' do
      job = create(:job, title: 'Dev Ruby')
      another_job = create(:job, title: 'Dev Javascript')
      one_more_job = create(:job, title: 'Dev Python')

      get api_v1_jobs_path
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[0][:title]).to eq('Dev Ruby')
      expect(json[1][:title]).to eq('Dev Javascript')
      expect(json[2][:title]).to eq('Dev Python')
    end

    it 'should return an empty array if there is no jobs' do
      get api_v1_jobs_path
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json).to eq([])
    end

    it 'should return 500 if there is a server error' do
      allow(Job).to receive(:all).and_raise(ActiveRecord::ActiveRecordError)

      get api_v1_jobs_path
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:internal_server_error)
      expect(json[:message]).to eq('Server Error')
    end
  end

  context 'create' do
    it 'successfully creates a job' do
      hunter = create(:hunter)
      job_count = Job.count

      post api_v1_jobs_path, params: { title: 'Dev Ruby', status: 'active',
                                       description: 'Trabalhar com Rails', 
                                       position: 'intern', location: 'Remoto',
                                       min_wage: 999, max_wage: 3001,
                                       deadline: Date.tomorrow, skills: 'TDD',
                                       hunter_id: hunter.id }
      json = JSON.parse(response.body, symbolize_names: true) 
  
      expect(response).to have_http_status(:created)
      expect(json[:title]).to eq('Dev Ruby')
      expect(json[:description]).to eq('Trabalhar com Rails')
      expect(json[:skills]).to eq('TDD')
      expect(json[:position]).to eq('intern')
      expect(json[:location]).to eq('Remoto')
      expect(json[:min_wage]).to eq(999)
      expect(json[:max_wage]).to eq(3001)
      expect(json[:deadline]).to eq(I18n.localize(Date.tomorrow, format: "%Y-%m-%d"))
      expect(json[:status]).to eq('active')
      expect(json[:hunter_id]).to eq(hunter.id)
      expect(Job.count).to eq(job_count + 1)
    end

    it 'should return validation errors if required fields are empty' do
      post api_v1_jobs_path, params: {}
      json = JSON.parse(response.body, symbolize_names: true) 
      
      expect(response).to have_http_status(:bad_request)
      expect(json[:message]).to include('A validação falhou')
      expect(json[:message]).to include('Hunter é obrigatório(a)')
      expect(json[:message]).to include('Título não pode ficar em branco')
      expect(json[:message]).to include('Descrição não pode ficar em branco')
      expect(json[:message]).to include('Salário Mínimo não pode ficar em branco')
      expect(json[:message]).to include('Salário Mínimo não é um número')
      expect(json[:message]).to include('Salário Máximo não pode ficar em branco')
      expect(json[:message]).to include('Salário Máximo não é um número')
      expect(json[:message]).to include('Data limite não pode ficar em branco')
    end
  end

  context 'update' do
    it 'should update all fields' do
      job = create(:job)
      hunter = create(:hunter)
      job_count = Job.count

      patch api_v1_job_path(job.id), params: {
                                      title: 'Dev Ruby', status: 'active',
                                      description: 'Trabalhar com Rails', 
                                      position: 'intern', location: 'Remoto',
                                      min_wage: 999, max_wage: 3001,
                                      deadline: Date.tomorrow, skills: 'TDD',
                                      hunter_id: hunter.id
                                    }
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[:title]).to eq('Dev Ruby')
      expect(json[:description]).to eq('Trabalhar com Rails')
      expect(json[:skills]).to eq('TDD')
      expect(json[:position]).to eq('intern')
      expect(json[:location]).to eq('Remoto')
      expect(json[:min_wage]).to eq(999)
      expect(json[:max_wage]).to eq(3001)
      expect(json[:deadline]).to eq(I18n.localize(Date.tomorrow,
                                                  format: "%Y-%m-%d"))
      expect(json[:status]).to eq('active')
      expect(json[:hunter_id]).to eq(hunter.id)
      expect(Job.count).to eq(job_count)
    end

    it 'should return 404 when id not found' do
      get api_v1_job_path(999)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:not_found)
      expect(json[:message]).to eq("Couldn't find Job with 'id'=999")
    end
  end

  context 'delete' do
    it 'should delete successfully' do
      job = create(:job)
      job_count = Job.count

      delete api_v1_job_path(job.id)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[:message]).to eq('Vaga deletada com sucesso')
      expect(Job.count).to eq(job_count - 1)
    end
  end
end