class SubscriberSupport
  class << self
    def get_import_data
      {
        :format      => "EmailAddress,First_Name,IsActive\r\n",
        :subscribers => "test@example.org,Test Subscriber,1\r\ntest2@example.org,Test Subscriber 2",
        :delimiter   => ","
      }
    end
  end
end
