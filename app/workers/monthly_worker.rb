class MonthlyWorker
  include Sidekiq::Worker

  def perform
    StatisticMailer.statistic_monthly_report.deliver_now
  end
end
