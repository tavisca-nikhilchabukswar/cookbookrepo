require 'chefspec'

describe 'filebeat_cookbook::default' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
                          .converge(described_recipe)
  end

  it 'installs a dpkg_package with the default action' do
    expect(chef_run).to install_dpkg_package('default_action')
    expect(chef_run).to_not install_dpkg_package('not_default_action')
  end
end
