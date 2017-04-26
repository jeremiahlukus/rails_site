namespace :db do
  task :backup do
    system <<~END
      mysqldump --opt
      --host=#{ENV['PH_MYSQL_HOST']}
      --user=#{ENV['PH_MYSQL_USERNAME']}
      --password=#{ENV['PH_MYSQL_PASSWORD']}
      ph_prod > backup.sql
    END
  end

  task :restore do
    system <<~END
      mysqldump
      --host=#{ENV['PH_MYSQL_HOST']}
      --user=#{ENV['PH_MYSQL_USERNAME']}
      --password=#{ENV['PH_MYSQL_PASSWORD']} < backup.sql
    END
  end
end
