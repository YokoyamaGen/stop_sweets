class ImportCsv
  # CSVデータのパスを引数として受け取り、インポート処理を実行
  def self.import(path)
    list = []

    CSV.foreach(path, headers: true) do |row|
      list << row.to_h
    end

    list
  end

  def self.information_data
    list = import('db/csv_data/information.csv')

    puts "インポート処理を開始"
    Information.create!(list)
    puts "インポート完了!"
  end
end