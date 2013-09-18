class PlatformController < ApplicationController
  before_filter :load_information_manager

  def index
    @worker_nodes = WorkerNode.all
    @managers = ScalarmManager.all.group_by(&:service_type)

    Rails.logger.debug("Worker nodes: #{@worker_nodes}")
    Rails.logger.debug("Managers: #{@managers}")
  end

  def synchronize
    ScalarmManager.delete_all
    WorkerNode.delete_all

    @information_manager.scalarm_services.each do |service_name, query_url|
      @information_manager.get_list_of(query_url).each do |manager_url|
        node_address = manager_url.split(':').first
        node = WorkerNode.find_by_url(node_address)
        node = WorkerNode.new(url: node_address) if node.nil?

        manager = ScalarmManager.find_by_url(manager_url)
        manager = ScalarmManager.new({url: manager_url, service_type: service_name}) if manager.nil?

        node.scalarm_managers << manager unless node.scalarm_managers.include?(manager)
        manager.worker_node = node unless manager.worker_node == node

        node.save
        manager.save
      end

    end

    redirect_to action: :index
  end

  protected

  def load_information_manager
    config = YAML.load_file(File.join(Rails.root, 'config', 'scalarm.yml'))
    Rails.logger.debug("Config: #{config}")
    @information_manager = InformationManager.new(config)
  end
end