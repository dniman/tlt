require './lib/destination'

namespace :destination do
  task :tables_instantiate! do
    Destination.tables_instantiate!
  end
end
