class CsvController < ApplicationController
  require 'csv'
  def read_csv
    log = Hash.new
    h = Hash.new
    prm = %w(name email contact password status)
    data = CSV.parse(File.read(params[:file]), headers: true)
    i = 1
    data.each do |row|
      row.delete_if{|key, value| !key.in? prm}
      @user = User.new(row.to_hash)
      if @user.save
        h["created"] = @user
        log["User #{i}"] = h["created"]
      else
        h["error"] = @user.errors.full_messages
        log["User #{i}"] = h["error"]
      end
      i = i + 1
    end
      render json: log
  end
end