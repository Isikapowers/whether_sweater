class BaseService
  # def request_api(path)
  #   conn.get()
  # end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
