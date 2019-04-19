require ('pg')

class SqlRunner

  def self.run(sql, values = [])#'values = []' sets this to an empty array if nothing passed to it
    begin
      db = PG.connect({dbname: 'cinema', host:'localhost'})
      db.prepare("query_var", sql)
      result = db.exec_prepared("query_var", values)
    ensure
      db.close() if db != nil # if database does not equal nil.
    end
    return result #returns result if there is anything to return.
  end


end
