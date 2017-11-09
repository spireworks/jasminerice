require 'spec_helper'

describe Jasminerice::SpecController, type: :controller do
  describe "view paths" do
    before do
      begin
        allow_any_instance_of(Jasminerice::SpecController).to receive(:render) {@view_paths = controller.view_paths}
        get 'fixtures', :use_route => :jasminerice
      rescue ActionController::UnknownFormat
      end
    end

    subject { @view_paths.to_a.flatten.map(&:to_s) }

    it { is_expected.to include Rails.root.to_s }
  end
end