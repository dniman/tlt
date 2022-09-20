module Destination
  class MssObjcorr 

    def self.mss_objcorr
      Destination.mss_objcorr
    end
    
    def self.delete_query(links:)
      Destination.set_engine!
     
      manager = Arel::DeleteManager.new(Database.destination_engine)
      manager.from (Destination.mss_objcorr)
      manager.where(Arel::Nodes::In.new(Destination.mss_objcorr[:link_s_corr],links))
      manager.to_sql
    end
    
  end
end
