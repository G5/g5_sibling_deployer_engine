namespace :sibling do
  desc "seeds siblings"
  task :consume => :environment do
    Resque.enqueue(SiblingConsumer)
  end
  desc "deploys all siblings"
  task :deploy => :environment do
    Sibling.deploy_all
  end
  namespace :instruction do
    desc "consumes instruction feed"
    task :consume => :environment do
      Resque.enqueue(SiblingInstructionConsumer)
    end
  end
end
