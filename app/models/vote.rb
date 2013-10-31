class Vote < ActiveRecord::Base
  belongs_to :answer
  
  def self.browser_detection(http)
      result  = http
      browser_name = 'n/a'
      if result =~ /Safari/
        unless result =~ /Chrome/
          version = result.split('Version/')[1].split(' ').first.split('.').first
          browser_name = "Safari"
        else
          version = result.split('Chrome/')[1].split(' ').first.split('.').first
          browser_name = 'Chrome'
        end
      elsif result =~ /Firefox/
        version = result.split('Firefox/')[1].split('.').first
        browser_name = 'Firefox'
      elsif result =~ /Opera/
        version = result.split('Version/')[1].split('.').first
        browser_name = "Opera"
      elsif result =~ /MSIE/
        version = result.split('MSIE')[1].split(' ').first
        browser_name = 'MSIE'
      else
        browser_name = "Other"
      end
      return browser_name
   end
   
end
