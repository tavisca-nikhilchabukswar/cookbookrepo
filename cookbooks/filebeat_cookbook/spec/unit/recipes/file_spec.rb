require 'chefspec'
describe 'filebeat_cookbook::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe) }
  it 'creates a directory with default action' do
	expect(chef_run).to create_directory('home/vagrant/filebeat')
  end
end
