namespace :jobs
  desc 'Run LotUpdater Worker'
  task :run_lot_updater => :environment do
    LotUpdater.perform_async
  end
end
