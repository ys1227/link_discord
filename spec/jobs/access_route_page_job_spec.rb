require "rails_helper"
require 'sidekiq/testing'


RSpec.describe AccessRoutePageJob, type: :worker do
  describe '#perform' do
    let(:url) { 'https://www.linkdisco-app.com' }

    before do
      # doubleでモックオブジェクトを作る
      allow(Net::HTTP).to receive(:get_response).and_return(double("HTTP Response", body: "Success"))
    end
    it '指定されたURLに対してHTTPリクエストを送る' do
      # described_classは現在テストしているクラスを指す。
      # perform_nowはバックグラウンドジョブシステムを介さずにジョブのコードを同期的に実行してテストをする。
      described_class.perform_now
      # 実際にテストが正しい引数を持ってNet::HTTPに対して呼ばれたかを確認している
      expect(Net::HTTP).to have_received(:get_response).with(URI(url))
    end
  end

  describe 'Sidekiqのキューにジョブが追加される' do
    before do
      Sidekiq::Worker.clear_all
    end
    example 'エンキューされたジョブが実行されること' do
      Sidekiq::Testing.fake!
      expect { AccessRoutePageJob.perform_later }.to change { Sidekiq::Queues["default"].size }.by(1)
    end
  end
end