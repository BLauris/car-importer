RSpec.configure do |config|

  # Before the entire test suite runs clear out any records in the test database
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  # Sets the default database cleaning strategy to be transaction, rather than
  # clearing out the entire database which is what the before(:suite) does
  config.before(:each) do |a|
    if a.metadata[:mixed_db_engines]
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
    end
  end

  # Runs before tests which have been flagged as js: true. Transactions do not
  # work for tests which involve javascript because those tests are run in a
  # Selenium powered web driver.
  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  # The next two sections hook the database cleaner around which ever test is
  # currently running and ensure that the test database is clean after each test.
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
