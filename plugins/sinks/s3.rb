class S3 < Sink
  
  def self.attribute_symbols
    [:access_key_id, :secret_access_key, :blanket_type]
  end
  
  def self.default_blanket_type
    "S3"
  end
    
  def self.default_access_key_id
    "your-id"
  end
  
  def self.default_secret_access_key
    "your-secret-ket"
  end
  
end