require './lib/source'

namespace :source do
  task :tables_instantiate! do
    Source.tables_instantiate!
  end
end
