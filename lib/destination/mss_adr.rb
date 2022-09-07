module Destination
  class MssAdr
    def self.mss_adr
      Destination.mss_adr
    end
    
    def self.update_query(row:, where:)
      manager = Arel::UpdateManager.new Database.destination_engine
      manager.table mss_adr
      manager.set([row.map(&:to_a).flatten])
      manager.where(where)
      manager.to_sql
    end
  end
end
